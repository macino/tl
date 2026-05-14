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
- Entities dir: `{{REPO_DIR}}/entities/`
- `(q)`, `(think)`, `(ctx)`, `(meta)`, `(idea)` prefixes = not a task, respond accordingly.
- `>>` = directive. Everything else is context/ambient.
