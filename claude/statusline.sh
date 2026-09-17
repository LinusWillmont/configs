#!/bin/bash
# Claude Code statusline command (configured in ~/.claude/settings.json).
# Receives session JSON on stdin. Prints the in-app statusline, and caches
# the rate_limits object so the tmux status bar can show usage too.

input=$(cat)

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/claude-code"
mkdir -p "$cache_dir"
printf '%s' "$input" | jq -c '.rate_limits // empty' >"$cache_dir/rate_limits.json" 2>/dev/null

model=$(printf '%s' "$input" | jq -r '.model.display_name // empty')
dir=$(printf '%s' "$input" | jq -r '.workspace.current_dir // empty')
usage=$("$(dirname "$(realpath "$0")")/usage.sh")

# $HOME is /home/$USER but cwd may report the /var/home physical path (Fedora).
dir="${dir/#\/var\/home\/$USER/\~}"
printf '%s | %s%s\n' "$model" "${dir/#$HOME/\~}" "${usage:+ | $usage}"
