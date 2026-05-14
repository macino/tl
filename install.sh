#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
SKILLS_DIR="$CLAUDE_DIR/skills/tl"
HOOKS_DIR="$CLAUDE_DIR/hooks"
GLOBAL_SETTINGS="$CLAUDE_DIR/settings.json"

ok()  { echo "  ✓ $*"; }
err() { echo "  ✗ $*" >&2; }

# Skills
mkdir -p "$SKILLS_DIR"
sed "s|{{REPO_DIR}}|$REPO_DIR|g" "$REPO_DIR/SKILL.md" > "$SKILLS_DIR/SKILL.md"
ok "~/.claude/skills/tl/SKILL.md"

# Entities dir
mkdir -p "$REPO_DIR/entities"
ok "entities/"

# Hook
mkdir -p "$HOOKS_DIR"
sed "s|{{REPO_DIR}}|$REPO_DIR|g" "$REPO_DIR/expand.sh" > "$HOOKS_DIR/tl-expand.sh"
chmod +x "$HOOKS_DIR/tl-expand.sh"
chmod +x "$REPO_DIR/toggle.sh"
ok "~/.claude/hooks/tl-expand.sh"

# Register hook in settings.json
if [[ -f "$GLOBAL_SETTINGS" ]]; then
    python3 - "$GLOBAL_SETTINGS" "$HOOKS_DIR/tl-expand.sh" <<'PYEOF'
import sys, json

settings_path = sys.argv[1]
hook_path = sys.argv[2]
hook_cmd = f'bash "{hook_path}"'

with open(settings_path) as f:
    s = json.load(f)

hooks = s.setdefault("hooks", {})
ups = hooks.setdefault("UserPromptSubmit", [])

already = any(
    any(h.get("command", "") == hook_cmd for h in entry.get("hooks", []))
    for entry in ups
)

if not already:
    ups.append({"hooks": [{"type": "command", "command": hook_cmd, "timeout": 5, "statusMessage": "TL expand..."}]})
    with open(settings_path, "w") as f:
        json.dump(s, f, indent=2)
    print("registered")
else:
    print("already registered")
PYEOF
    ok "~/.claude/settings.json — TL hook registered"
else
    err "~/.claude/settings.json not found — add TL hook manually"
    err "  command: bash \"$HOOKS_DIR/tl-expand.sh\""
    err "  event:   UserPromptSubmit"
fi

echo ""
ok "Done. Restart Claude Code, then use /tl to toggle."
