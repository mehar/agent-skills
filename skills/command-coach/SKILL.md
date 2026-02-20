---
name: command-coach
description: Teach users how to run commands effectively while completing their request. Use when the user asks for command coaching, asks how to do something efficiently in terminal/git, or asks to turn coaching mode on/off.
---

# Command Coach

Provide concise, practical command coaching while still executing the user's request.

## Trigger Conditions

Use this skill when the user:

- asks to "teach me", "coach me", or "show best way" for shell/git usage
- asks for efficient, safer, or faster command patterns
- asks to toggle coaching behavior on or off
- requests explanation of command output with practical usage guidance

## Coaching State

- `Coach ON`: add a short coaching block to each relevant response.
- `Coach OFF`: execute/respond normally with no coaching block.
- If the user says "coach on", "coaching on", or equivalent, enable `Coach ON`.
- If the user says "coach off", "stop coaching", or equivalent, enable `Coach OFF`.
- Keep the chosen state for the current conversation until the user changes it.

## Operating Rules

1. For bare command prompts, first suggest the `!command` form so the user can run it directly.
2. Execute the command yourself only when the user explicitly asks the agent to run it or when interpretation/debugging is requested.
3. For non-command questions, answer directly.
4. After results or guidance, add coaching when `Coach ON`.
5. Add coaching only after giving the actual result.
6. Keep coaching short and actionable.
7. Tailor advice to the exact command/question the user asked.
8. Prefer safe defaults:
   - explicit file/branch targets over broad patterns
   - dry-run/preview options when available
   - non-destructive alternatives before destructive actions
9. For direct terminal command requests, recommend `!command` as the default way for users to run commands themselves and get immediate output.

## Coaching Response Format

When `Coach ON`, append:

### Do It Effectively

1. Best-practice command pattern for this exact task.
2. One common pitfall to avoid.
3. One faster or safer variant.

Keep each point to one sentence unless a short command example is needed.

## Command-Specific Guidance

### Terminal command execution

- Prefer `!<command>` for user-run terminal commands in this environment, example: `!ls -la`.
- If the user types a bare command (like `ls`), coach them to use the `!` form for faster execution.
- If the user includes execution intent ("run this", "execute", "show me output"), run the command and then coach.
- Use agent-executed commands when interpretation, debugging, or multi-step automation is needed.

### Shell navigation and listing

- Prefer `pwd`, `ls -la`, and targeted paths (`ls -la docs/`) over repeated blind listing.
- Use `rg --files` for fast file discovery in repos.

### Search and inspection

- Prefer `rg "pattern"` over `grep -R` for speed and clarity.
- Use `sed -n 'start,endp' <file>` for scoped reads instead of dumping full files.

### Git staging and commits

- Prefer `git add <paths>` or `git add -p` over `git add .` when precision matters.
- Use commit subjects in imperative mood and include ticket prefix when required.

### Git history and review

- Use `git status` before and after edits.
- Use `git diff -- <file>` for scoped review, then `git diff --staged` before commit.

### Risk controls

- Call out destructive commands explicitly (`reset --hard`, `clean -fd`, broad `rm`).
- Recommend backups, previews, or safer equivalents when possible.

## Boundaries

- Do not flood the user with generic tips.
- Do not repeat the same coaching text verbatim each turn.
- If the user asks for "just the output" or turns coaching off, do not append coaching.
