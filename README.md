# dotfiles

Personal dev environment for macOS, managed as topic-based dotfiles.

This has been an ongoing project that has followed me throughough my development career. It originally started
as a fork from [Zach Holman's dotfiles](https://github.com/holman/dotfiles) at I time when I had no idea
dotfiles could be so thoughtful and organized. Now with the advent of AI, two things have happened resulting in
the rework of these files. First, AI is moving in the direction where I'm spending more time in the terminal.
And, AI has helped me structure these in a way that would have taken several weekends before. These files
legitimately bring me a lot of joy in my day-to-day, and I hope you find something useful in them as well.

## Stack

| Category | Tool |
|----------|------|
| Shell | zsh + [Zinit](https://github.com/zdharma-continuum/zinit) (plugin manager) |
| Prompt | [Starship](https://starship.rs) |
| Terminal | [Ghostty](https://ghostty.org) (Solarized, JetBrainsMono Nerd Font) |
| Editor | [Zed](https://zed.dev) (Solarized, JetBrains keymap) |
| Runtime manager | [mise](https://mise.jdx.dev) (Node, Ruby, Java, Python) |
| Git | GPG-signed commits, [delta](https://github.com/dandavies00/delta) (side-by-side diffs), [lazygit](https://github.com/jesseduffield/lazygit) |
| File navigation | [zoxide](https://github.com/ajeetdsouza/zoxide) (`z` / `zi`), [fzf](https://github.com/junegunn/fzf) + [fzf-tab](https://github.com/Aloxaf/fzf-tab), [fd](https://github.com/sharkdp/fd) |
| File viewing | [eza](https://github.com/eza-community/eza) (`ls`), [bat](https://github.com/sharkdp/bat) (`cat`), [grc](https://github.com/garabik/grc) (colorized output) |

## Structure

Everything is organized by topic. Each directory can contain:

- **`*.zsh`** -- Loaded automatically into the shell environment
- **`path.zsh`** -- Loaded first, sets up `$PATH`
- **`completion.zsh`** -- Loaded last, after `compinit`
- **`install.sh`** -- Run by `script/install`
- **`*.symlink`** -- Symlinked into `$HOME` (without the `.symlink` extension)

### Shell load order

`zshrc.symlink` sources files in this order:

1. `**/path.zsh` -- PATH setup (`system/_path.zsh`)
2. `**/*.zsh` (excluding path/completion) -- alphabetical within each topic:
   - `system/env.zsh` -- `$EDITOR`
   - `system/grc.zsh` -- colorized CLI output
   - `zsh/aliases.zsh` -- eza/bat aliases
   - `zsh/config.zsh` -- shell options, `$HOMEBREW_PREFIX` cache
   - `zsh/fpath.zsh` -- function/completion paths, Docker completions
   - `zsh/fzf.zsh` -- fzf keybindings, fd integration
   - `zsh/mise.zsh` -- runtime version manager
   - `zsh/starship.zsh` -- prompt
   - `zsh/zinit.zsh` -- plugins (OMZ snippets, autosuggestions, syntax highlighting, fzf-tab, zoxide)
3. `compinit` -- completion system (cached daily)
4. `**/completion.zsh` -- post-compinit completions

### Key files

```
Brewfile                     # Homebrew dependencies
bin/                         # Scripts added to $PATH
  dot                        #   Update script (brew, installers, macOS defaults)
  e                          #   Open $EDITOR shortcut
ghostty/config               # Ghostty terminal config
git/gitconfig.symlink        # Git config (delta, GPG, aliases)
git/gitconfig.local.symlink  # Machine-local git config (credentials)
git/gitignore_global.symlink # Global gitignore
macos/set-defaults.sh        # macOS preferences (key repeat, Finder, etc.)
vim/vimrc.symlink            # Minimal vim config (fallback editor)
zed/settings.json            # Zed editor config
zsh/zshrc.symlink            # Shell entry point
```

## Install

```sh
git clone https://github.com/bheus/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This symlinks dotfiles into `$HOME`, installs Homebrew dependencies, and runs topic installers.

To update later:

```sh
dot
```

## Performance

Shell startup is optimized via:
- Cached `brew --prefix` (single call shared across files)
- Daily `compinit` cache (`compinit -C`)
- fzf uses `fd` instead of `find`
- Zinit lazy-loads plugins

Target startup: under 250ms.
