#add each topic folder to fpath so that they can add functions and completion scripts
for topic_folder ($ZSH/*) if [ -d $topic_folder ]; then  fpath=($topic_folder $fpath); fi;

# Homebrew completions (must be on fpath before compinit)
if [ -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]; then
  fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
fi

# Docker Desktop completions
if [ -d "$HOME/.docker/completions" ]; then
  fpath=($HOME/.docker/completions $fpath)
fi
