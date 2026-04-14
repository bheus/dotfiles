# Cache brew prefix (used across multiple zsh files)
export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix)}"

setopt rmstarsilent
setopt extendedglob