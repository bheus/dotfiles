# Initialize zinit
source $(brew --prefix)/opt/zinit/zinit.zsh

# Oh-my-zsh snippets — only load what we actually use
zi snippet OMZ::plugins/git/git.plugin.zsh
zi snippet OMZ::plugins/extract/extract.plugin.zsh
zi snippet OMZ::plugins/copypath/copypath.plugin.zsh

# Plugins
zi light zsh-users/zsh-autosuggestions
zi light zsh-users/zsh-syntax-highlighting
zi light Aloxaf/fzf-tab

# Free up `zi` alias so zoxide can use it for interactive picker
unalias zi 2>/dev/null

# zoxide replaces z (must load after zinit to reclaim `zi`)
eval "$(zoxide init zsh)"
