# Personal Agent Skills Repository

This repository stores reusable skills for agent workflows.

## Structure

- `skills/` - one folder per skill
- `scripts/` - optional helper scripts for skill scaffolding/validation

## Skill Layout

Each skill should follow:

```text
<skill-name>/
├── SKILL.md
├── agents/
│   └── openai.yaml
├── scripts/      (optional)
├── references/   (optional)
└── assets/       (optional)
```

## Quick Start

1. Copy `skills/personal-starter` to a new folder in `skills/`.
2. Rename the folder to your skill name (kebab-case).
3. Update `SKILL.md` frontmatter (`name`, `description`) and body.
4. Update `agents/openai.yaml` fields.
5. Remove any placeholder files you do not need.
