#!/bin/bash
# Script Filter: list ~/Downloads newest-first as Alfred file results.
# Honors an optional query ($1) for fuzzy substring matching on filename.

query="${1:-}"
downloads="$HOME/Downloads"
limit=30

cd "$downloads" || exit 0

# -t sorts by mtime desc; -A includes dotfiles except . and ..
while IFS= read -r name; do
  [ -z "$name" ] && continue
  if [ -n "$query" ]; then
    # case-insensitive substring match
    shopt -s nocasematch
    [[ "$name" != *"$query"* ]] && continue
    shopt -u nocasematch
  fi
  path="$downloads/$name"
  # escape for JSON
  esc_name=$(printf '%s' "$name" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')
  esc_path=$(printf '%s' "$path" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')
  printf '%s\n' "{\"type\":\"file\",\"title\":${esc_name},\"subtitle\":${esc_path},\"arg\":${esc_path},\"icon\":{\"type\":\"fileicon\",\"path\":${esc_path}},\"quicklookurl\":${esc_path}}"
done < <(ls -tA "$downloads" | head -n "$limit") | {
  printf '{"items":['
  first=1
  while IFS= read -r item; do
    if [ $first -eq 1 ]; then
      first=0
    else
      printf ','
    fi
    printf '%s' "$item"
  done
  printf ']}\n'
}
