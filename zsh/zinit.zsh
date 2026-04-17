# Initialize zinit
source $HOMEBREW_PREFIX/opt/zinit/zinit.zsh

# Oh-my-zsh snippets — only load what we actually use
zi snippet OMZ::plugins/git/git.plugin.zsh
zi snippet OMZ::plugins/extract/extract.plugin.zsh
zi snippet OMZ::plugins/copypath/copypath.plugin.zsh

# Plugins (fzf-tab and syntax-highlighting load post-compinit in completion.zsh)
zi light zsh-users/zsh-autosuggestions

# Free up `zi` alias so zoxide can use it for interactive picker
unalias zi 2>/dev/null

# zoxide replaces z (must load after zinit to reclaim `zi`)
eval "$(zoxide init zsh)"
