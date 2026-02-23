---
name: pandoc-md-to-html
description: Convert Markdown files to browser-ready HTML using pandoc. Use when asked to convert .md files to .html, preview Markdown in a browser, or render Mermaid diagrams in generated HTML.
---

# Pandoc Markdown To HTML

Convert Markdown to HTML with `pandoc`, and optionally enable Mermaid diagram rendering for ```mermaid blocks.

## Inputs To Confirm

- Source markdown path.
- Output HTML path. If omitted, use the source filename with `.html`.
- Whether Mermaid diagrams should render in browser.
- Whether to open the output after conversion.

## Workflow

1. Validate prerequisites.
Run `pandoc --version` and fail fast if `pandoc` is not installed.

2. Resolve paths.
Make source and output paths explicit and ensure the output directory exists.

3. Convert markdown.
For plain conversion, run:
```bash
pandoc <input.md> -s -o <output.html>
```

4. Convert with Mermaid support (if requested).
Run the bundled script so Mermaid code blocks render in browser:
```bash
scripts/convert_md_to_html.sh --input <input.md> --output <output.html> --mermaid
```

5. Open output (if requested).
Use:
```bash
open <output.html>
```
or explicitly:
```bash
open -a "Google Chrome.app" <output.html>
```

## Notes

- Mermaid rendering requires network access at view time because it loads Mermaid from jsDelivr CDN.
- Prefer standalone output (`-s`) for browser preview portability.
