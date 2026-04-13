local _fzf_prefix="$(brew --prefix fzf)"

if [[ ! "$PATH" == *"$_fzf_prefix/bin"* ]]; then
  export PATH="$PATH:$_fzf_prefix/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$_fzf_prefix/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$_fzf_prefix/shell/key-bindings.zsh"
