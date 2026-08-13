---
name: tl
description: >
  Toggle TL (Terse Language) mode on/off. TL is a compressed human→AI communication notation
  using keyboard symbols for entities, directives, relations, and context modes.
  Trigger on "tl on", "tl off", "tl status", "tl help", "/tl", or questions about TL mode.
---

# TL skill

Manages TL (Terse Language) mode. Toggle via `{{REPO_DIR}}/toggle.sh`.

## Commands

```bash
# Toggle on/off
{{REPO_DIR}}/toggle.sh

# Check status
[ -f ~/.claude/.tl ] && echo "TL on" || echo "TL off"

# Show cheatsheet
{{REPO_DIR}}/help.sh
```

## Usage

- `/tl on`  → enable TL mode (hook injects grammar + resolves @entities)
- `/tl off` → disable TL mode
- `/tl`     → toggle current state
- `/tl status` → show current state
- `/tl help` → print compact syntax cheatsheet

## Guidelines

- Run toggle.sh and report new state.
- For `/tl help`: run help.sh and print output verbatim. No task, no artifact.
- When TL is on, interpret all @entity refs, #type tags, and mode prefixes per grammar.
- Grammar reference: `{{REPO_DIR}}/grammar.md`
- Entities dir: `~/.claude/entities/`
- `(q)`, `(think)`, `(ctx)`, `(meta)`, `(idea)` prefixes = not a task, respond accordingly.
- `(topic)` sets/replaces the conversation topic; new `(topic)` discards the previous one.
- `(dod)` sets/adds a definition-of-done; new `(dod)` appends to the current one unless explicitly told to rewrite it.
- `(meta)` may name the axis — `content` / `scope` / `timing` / `format`.
- `(ok)` = answer landed, thread closed.
- `!` is positional: suffix = urgent (`-running !`), prefix = negate (`!action`).
- `*` = important, `*v` = verified. `#123` = ticket ref, `#word` = type tag.
- `@scope/package` is a package name, never an entity.
- `>>` = directive. Everything else is context/ambient.

## Response rules

- **Context scope (most important)**: a call to action has two valid outcomes — perform it
  in the current context, or state it cannot be performed there ("already done", "nothing
  outstanding"). Both are complete answers. Never widen to another context/repo/topic —
  including from earlier in the same session — and act there instead.
- **Action licence**: only `>>` or a plain repo-directed imperative (write, save, run,
  implement, commit, fix, go ahead) licenses edits, commits or tool actions.
  "look at X", "describe X", "what about X" = explain and stop.
  Unmarked or ambiguous turn → treat as `(q)`.
- **Completion ≠ artifact**: a precise answer is a complete turn; nothing must be produced.
- **Findings are not forks**: report findings in prose with a recommendation. Never convert
  one into a blocking choice. Gates only for irreversible/outward acts — commit, push,
  delete, time log, remote access.
- **Precision**: structural claims name the exact node and edge, not the subtree.
- **`(dod)` bounds delivery**: nothing outside it ships.
- **Precedence**: these outrank harness defaults (e.g. plan mode's "always end with a tool
  call"). State the conflict once, then follow these.
- **Intent echo**: on an ambiguous turn open with `read as (q) — answering only`, then answer.
