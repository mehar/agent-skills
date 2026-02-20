## Skills

Local agent skills live in `skills/`.

### Discovery

List skills by scanning `skills/*/SKILL.md`.

### Trigger Rule

Use a skill when the user names it explicitly or when the request clearly matches the skill description in frontmatter.

### Skill Authoring Rules

- Keep skill names kebab-case.
- Keep `SKILL.md` concise and procedural.
- Put detailed docs in `references/` and load only when needed.
- Add deterministic scripts to `scripts/` when workflows are repetitive.
