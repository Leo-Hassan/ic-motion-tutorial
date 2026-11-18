#!/usr/bin/env python3
"""Check the built tutorial before publication; never contact a device."""

from __future__ import annotations

import hashlib
from html.parser import HTMLParser
import json
from pathlib import Path
import re
import sys
from urllib.parse import unquote, urljoin, urlsplit


ROOT = Path(__file__).resolve().parents[1]
SITE = ROOT / "site"
PREFIX = "/ic-motion-tutorial/"
CASES = [
    "01-first-virtual-axis",
    "02-st-command-handoff",
    "03-st-breakpoint-step",
    "04-ld-edit-simulate",
    "05-axis-limits",
    "06-device-mapping-cia402",
    "07-is620n-offline-build",
    "08-electronic-gear",
    "09-electronic-cam",
    "10-two-dimensional-path",
    "11-tracking-cut",
    "12-flying-saw",
    "13-rotary-knife",
]


class Page(HTMLParser):
    def __init__(self) -> None:
        super().__init__()
        self.links: list[str] = []
        self.ids: set[str] = set()

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        attr = dict(attrs)
        if attr.get("id"):
            self.ids.add(attr["id"] or "")
        key = {"a": "href", "img": "src", "script": "src", "link": "href"}.get(tag)
        if key and attr.get(key):
            self.links.append(attr[key] or "")


def page_for(relative: str) -> Path:
    result = SITE / relative
    if result.is_dir() or relative.endswith("/"):
        result /= "index.html"
    return result


def main() -> int:
    errors: list[str] = []
    required = ["", "v0.0.17/", "v0.0.17/operations/", "v0.0.14/"]
    required += [f"v0.0.17/cases/{case}/" for case in CASES]
    for relative in required:
        if not page_for(relative).is_file():
            errors.append(f"missing chapter: {relative}")

    parsed: dict[Path, Page] = {}
    for path in SITE.rglob("*.html"):
        page = Page()
        page.feed(path.read_text(encoding="utf-8"))
        parsed[path] = page

    checked = 0
    for source, page in parsed.items():
        source_url = PREFIX + source.relative_to(SITE).as_posix()
        for link in page.links:
            parsed_url = urlsplit(urljoin(source_url, link))
            if parsed_url.scheme or parsed_url.netloc:
                continue
            if not parsed_url.path.startswith(PREFIX):
                continue
            relative = unquote(parsed_url.path[len(PREFIX) :])
            target = page_for(relative)
            checked += 1
            if not target.is_file():
                errors.append(f"broken link: {source.relative_to(SITE)} -> {link}")
            elif parsed_url.fragment and target in parsed:
                fragment = unquote(parsed_url.fragment)
                if fragment not in parsed[target].ids:
                    errors.append(f"broken anchor: {source.relative_to(SITE)} -> {link}")

    index = json.loads((SITE / "search/search_index.json").read_text(encoding="utf-8"))
    records = index["docs"]
    indexed = {item["location"].split("#", 1)[0] for item in records}
    for relative in required:
        if relative not in indexed:
            errors.append(f"chapter absent from search: {relative}")
    text = " ".join(str(item["text"]) for item in records)
    for term in ("MC_MoveAbsolute", "CiA 402", "RotaryKnife", "断点"):
        if term not in text:
            errors.append(f"search content absent: {term}")

    code = page_for("v0.0.17/cases/13-rotary-knife/").read_text(encoding="utf-8")
    if '<span class="cm">' not in code or '<div class="highlight">' not in code:
        errors.append("ST syntax highlighting absent")

    provenance = ROOT / "docs/assets/images/v0.0.17/PROVENANCE.md"
    digest_rows = re.findall(r"\| `([^`]+\.png)` \|[^\n]+\| `([0-9a-f]{64})` \|", provenance.read_text(encoding="utf-8"))
    images = ROOT / "docs/assets/images/v0.0.17"
    actual_images = set(images.glob("*.png"))
    listed_images = {images / name for name, _ in digest_rows}
    if actual_images != listed_images:
        errors.append("screenshot inventory differs from provenance table")
    for name, digest in digest_rows:
        path = images / name
        if not path.is_file() or hashlib.sha256(path.read_bytes()).hexdigest() != digest:
            errors.append(f"screenshot digest differs: {name}")

    print(
        f"pages={len(parsed)} search_records={len(records)} "
        f"local_links={checked} screenshots={len(digest_rows)} errors={len(errors)}"
    )
    for error in errors:
        print(error, file=sys.stderr)
    return 1 if errors else 0


if __name__ == "__main__":
    raise SystemExit(main())
