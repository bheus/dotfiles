# Cache brew prefix (used across multiple zsh files)
export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix)}"

setopt rmstarsilent
setopt extendedglob

# Pager: moor handles mouse scrolling, search, and ANSI colors natively
export PAGER=moor
export MANPAGER=moor
export DELTA_PAGER=moor