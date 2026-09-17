#!/bin/bash
# Print Claude Code usage limits (5h session + weekly) from the cache written
# by statusline.sh. Data only refreshes while a Claude Code session is open.
# --tmux wraps the percentages in Catppuccin Macchiato colours.

# printf %f must accept dot-decimals from the JSON regardless of user locale.
export LC_NUMERIC=C

cache="${XDG_CACHE_HOME:-$HOME/.cache}/claude-code/rate_limits.json"
[ -s "$cache" ] || exit 0

tmux_mode=false
[ "$1" = "--tmux" ] && tmux_mode=true

# resets_at can be epoch seconds or an ISO timestamp - normalise to epoch.
to_epoch() {
  case "$1" in
  '' | null | 0) echo 0 ;;
  *[!0-9.]*) date -d "$1" +%s 2>/dev/null || echo 0 ;;
  *) printf '%.0f\n' "$1" ;;
  esac
}

colour() { # $1 = percentage
  if [ "$1" -ge 80 ]; then echo '#ed8796'; # red
  elif [ "$1" -ge 50 ]; then echo '#eed49f'; # yellow
  else echo '#a6da95'; fi # green
}

now=$(date +%s)
out=""
while IFS=$'\t' read -r label pct reset; do
  [ "$pct" = null ] && continue
  # A passed reset time means the window rolled over since we last cached.
  [ "$(to_epoch "$reset")" -lt "$now" ] && pct=0
  if $tmux_mode; then
    part="$label #[fg=$(colour "$pct")]$pct%#[default]"
  else
    part="$label $pct%"
  fi
  out="${out:+$out · }$part"
done < <(jq -r '
  ["5h", (.five_hour.used_percentage | if . == null then null else round end), .five_hour.resets_at],
  ["wk", (.seven_day.used_percentage | if . == null then null else round end), .seven_day.resets_at] | @tsv' "$cache" 2>/dev/null)

[ -n "$out" ] && printf '%s\n' "$out"
