#!/usr/bin/env bash
# TL expand hook — UserPromptSubmit
# Injects TL grammar + resolves @entity refs as system context.
# Enabled when ~/.claude/.tl flag file exists.

[ -f "$HOME/.claude/.tl" ] || exit 0

REPO_DIR="{{REPO_DIR}}"
ENTITIES_DIR="$HOME/.claude/entities"
GRAMMAR_FILE="$REPO_DIR/grammar.md"

# Read prompt from stdin JSON
prompt=$(python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('prompt', ''))
except Exception:
    pass
" 2>/dev/null)

output=""

# Inject grammar
if [ -f "$GRAMMAR_FILE" ]; then
    output+="TL (Terse Language) active. Interpret all @entity refs, #type tags, and mode prefixes per grammar below. TL is bidirectional — also use TL symbols in your responses per the Output encoding section.\n\n"
    output+="$(cat "$GRAMMAR_FILE")\n\n"
fi

# Resolve @entity refs found in prompt
if [ -n "$prompt" ] && [ -d "$ENTITIES_DIR" ]; then
    # trailing "/" is captured so scoped package names (@previo/design-system) can be
    # dropped — they are npm scopes, not entity refs
    entities=$(echo "$prompt" | grep -oE '@[a-zA-Z][a-zA-Z0-9_-]*/?' | grep -v '/$' | sort -u)
    while IFS= read -r ref; do
        [ -z "$ref" ] && continue
        name="${ref#@}"
        file="$ENTITIES_DIR/$name.md"
        if [ -f "$file" ]; then
            output+="Entity @$name:\n$(cat "$file")\n\n"
        fi
    done <<< "$entities"
fi

[ -n "$output" ] && printf '%s' "$output"
exit 0
