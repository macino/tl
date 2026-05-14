#!/usr/bin/env bash
# Toggle TL mode on/off via ~/.claude/.tl flag file.

FLAG="$HOME/.claude/.tl"

case "${1:-}" in
    on)
        touch "$FLAG"
        echo "TL on"
        ;;
    off)
        rm -f "$FLAG"
        echo "TL off"
        ;;
    status)
        [ -f "$FLAG" ] && echo "TL on" || echo "TL off"
        ;;
    *)
        if [ -f "$FLAG" ]; then
            rm -f "$FLAG"
            echo "TL off"
        else
            touch "$FLAG"
            echo "TL on"
        fi
        ;;
esac
