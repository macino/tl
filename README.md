# TL — Terse Language

Compressed human→AI communication using keyboard symbols.
Target: minimize keystrokes, maximize information density.
Works anywhere Claude Code is running (global hook).

---

## Install

```bash
git clone git@github.com:macino/tl.git ~/path/to/tl
cd ~/path/to/tl
./install.sh
# Restart Claude Code
```

Entities live at `entities/` inside the cloned repo (gitignored — local only).

---

## Quick Start

```bash
# Enable
/tl on

# Disable
/tl off
```

---

## Core Symbols

| Symbol | Meaning | Example |
|--------|---------|---------|
| `>>` | directive — do this | `>> refactor auth` |
| `??` | explain / why / how | `@cache miss ??` |
| `?=` | what is the value | `@config ?= timeout` |
| `?` | yes/no question | `@server running?` |
| `=` | is / state | `@server = -running` |
| `!=` | is-not / wrong | `response != expected` |
| `->` | results-in | `null deref -> crash` |
| `~` | uncertain | `~ bug = @auth` |
| `*` | important / verified | `* deadline = friday` |
| `!` | urgent | `@server = -running !` |
| `+` | add / increase | `+feature-x` |
| `-` | remove / negate | `-debug-log` |

---

## Structure

| Symbol | Meaning | Example |
|--------|---------|---------|
| `[]` | context frame | `[#bug @auth]` |
| `()` | metadata / not a task | `(think) maybe split service` |
| `{}` | set / options | `>> {A \| B}` |
| `\|` | or | `fix \| skip` |
| `@name` | entity ref → `entities/name.md` | `@server`, `@tomas` |
| `#tag` | type / category | `#bug`, `#low`, `#task` |
| `::` | means / defined-as | `timeout :: 30s` |

---

## Mode Prefixes

These signal intent — I respond differently to each:

| Prefix | Meaning | My behavior |
|--------|---------|-------------|
| `(q)` | question, no task | answer only, no artifacts |
| `(think)` | thinking out loud | optional response |
| `(ctx)` | context update | acknowledge, no action |
| `(meta)` | about our interaction | discuss how we work |
| `(idea)` | half-baked, not directive | explore, don't implement |

---

## Entity Files

`@name` resolves to `entities/name.md` in the ai-wkf repo.
When TL is on, I automatically load entity files found in your message.

Create an entity:

```bash
# entities/server.md
host: api.example.com
port: 8080
env: staging
notes: flaky under load, restart fixes it
```

Then use: `@server = -running !` — I already know what @server is.

---

## Examples

```
# Urgent: server down
@server = -running !

# Why is memory growing?
@memory + ??

# Add low-priority feature to auth module
[#low] @auth >> +feature-x

# Uncertain bug location
~~ bug = @auth

# Do one of two things, your call
>> {refactor-inline | extract-service}

# What's the configured timeout?
@config ?= timeout

# Bug in auth, investigate because server is down
[#bug @auth] >> investigate ^ @server = -running

# Casual question, no task
(q) ?? TL good for team use?

# Thinking out loud
(think) maybe auth should split into two services

# Context update, no action needed
(ctx) @project = paused until friday

# Feedback on my behavior
(meta) last response too long
```

---

## Entity File Format

```markdown
# @entity-name

key: value
key: value

## Notes
Free text context, known issues, gotchas.
```

---

## Toggle Commands

```
/tl          toggle on/off
/tl on       enable
/tl off      disable
/tl status   show current state
```

---

## How It Works

1. `install.sh` registers `expand.sh` as a global `UserPromptSubmit` hook
2. Hook checks `~/.claude/.tl` flag
3. If on: injects TL grammar + resolves `@entity` refs into every prompt as system context
4. Works in any project directory — grammar and entities come from the cloned repo
