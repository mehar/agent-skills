#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: scripts/new-skill.sh <skill-name>"
  exit 1
fi

SKILL_NAME="$1"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT_DIR/skills/personal-starter"
DST="$ROOT_DIR/skills/$SKILL_NAME"

if [[ ! "$SKILL_NAME" =~ ^[a-z0-9-]+$ ]]; then
  echo "Error: skill name must be kebab-case (lowercase letters, digits, hyphens)."
  exit 1
fi

if [[ -d "$DST" ]]; then
  echo "Error: skill already exists: $DST"
  exit 1
fi

cp -R "$SRC" "$DST"

sed -i.bak "s/^name: .*/name: $SKILL_NAME/" "$DST/SKILL.md"
rm "$DST/SKILL.md.bak"

echo "Created skill scaffold at: $DST"
echo "Next: update $DST/SKILL.md and $DST/agents/openai.yaml"
