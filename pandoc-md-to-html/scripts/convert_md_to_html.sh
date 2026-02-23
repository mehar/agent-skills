#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage:
  convert_md_to_html.sh --input <input.md> [--output <output.html>] [--mermaid]

Options:
  --input     Source markdown file path (required)
  --output    Output HTML path (default: input filename with .html)
  --mermaid   Inject Mermaid runtime so mermaid code fences render in browser
USAGE
}

INPUT=""
OUTPUT=""
MERMAID=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --input)
      INPUT="${2:-}"
      shift 2
      ;;
    --output)
      OUTPUT="${2:-}"
      shift 2
      ;;
    --mermaid)
      MERMAID=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "$INPUT" ]]; then
  echo "Missing required --input argument." >&2
  usage
  exit 1
fi

if [[ ! -f "$INPUT" ]]; then
  echo "Input file not found: $INPUT" >&2
  exit 1
fi

if ! command -v pandoc >/dev/null 2>&1; then
  echo "pandoc is not installed or not in PATH." >&2
  exit 1
fi

if [[ -z "$OUTPUT" ]]; then
  OUTPUT="${INPUT%.*}.html"
fi

mkdir -p "$(dirname "$OUTPUT")"

if [[ "$MERMAID" == "true" ]]; then
  HEADER_FILE="$(mktemp)"
  trap 'rm -f "$HEADER_FILE"' EXIT

  cat > "$HEADER_FILE" <<'HEADER'
<script type="module">
  import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";

  mermaid.initialize({ startOnLoad: false, securityLevel: "loose" });

  function promoteMermaidBlocks() {
    const blocks = document.querySelectorAll("pre.mermaid");
    for (const pre of blocks) {
      const code = pre.querySelector("code");
      const source = code ? code.textContent : pre.textContent;
      const div = document.createElement("div");
      div.className = "mermaid";
      div.textContent = source || "";
      pre.replaceWith(div);
    }
  }

  window.addEventListener("DOMContentLoaded", async () => {
    promoteMermaidBlocks();
    await mermaid.run({ querySelector: ".mermaid" });
  });
</script>
HEADER

  pandoc "$INPUT" -s -o "$OUTPUT" --include-in-header "$HEADER_FILE"
else
  pandoc "$INPUT" -s -o "$OUTPUT"
fi

echo "Generated: $OUTPUT"
