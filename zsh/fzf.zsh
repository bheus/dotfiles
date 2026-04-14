local _fzf_prefix="$HOMEBREW_PREFIX/opt/fzf"

if [[ ! "$PATH" == *"$_fzf_prefix/bin"* ]]; then
  export PATH="$PATH:$_fzf_prefix/bin"
fi

# Use fd for faster traversal (respects .gitignore)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Auto-completion
[[ $- == *i* ]] && source "$_fzf_prefix/shell/completion.zsh" 2> /dev/null

# Key bindings
source "$_fzf_prefix/shell/key-bindings.zsh"
