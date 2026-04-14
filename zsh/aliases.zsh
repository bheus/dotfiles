# eza replaces ls
if (( $+commands[eza] )); then
  alias ls='eza --icons'
  alias ll='eza -lah --icons --git'
  alias la='eza -a --icons'
  alias lt='eza --tree --icons --level=2'
fi

# bat replaces cat (already installed)
if (( $+commands[bat] )); then
  alias cat='bat'
fi
