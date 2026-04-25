# dotfiles

Personal dev environment for macOS, managed as topic-based dotfiles.

This has been an ongoing project that has followed me throughout my development career. It originally started
as a fork from [Zach Holman's dotfiles](https://github.com/holman/dotfiles) at a time when I had no idea
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
| Window manager | [AeroSpace](https://github.com/nikitabobko/AeroSpace) (tiling, Dvorak bindings) + [JankyBorders](https://github.com/FelixKratz/JankyBorders) |
| Key remapping | [Karabiner-Elements](https://karabiner-elements.pqrs.org) (caps → hyper) |
| Runtime manager | [mise](https://mise.jdx.dev) (Node, Ruby, Java, Python) |
| Git | GPG-signed commits, [delta](https://github.com/dandavison/delta) (side-by-side diffs), [lazygit](https://github.com/jesseduffield/lazygit) |
| File navigation | [zoxide](https://github.com/ajeetdsouza/zoxide) (`z` / `zi`), [fzf](https://github.com/junegunn/fzf) + [fzf-tab](https://github.com/Aloxaf/fzf-tab), [fd](https://github.com/sharkdp/fd) |
| File viewing | [eza](https://github.com/eza-community/eza) (`ls`), [bat](https://github.com/sharkdp/bat) (`cat`), [grc](https://github.com/garabik/grc) (colorized output) |
| Pager | [moor](https://github.com/walles/moor) (`$PAGER`, `$MANPAGER`, `$DELTA_PAGER`) |

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
   - `system/grc.zsh` -- colorized CLI output
   - `zed/env.zsh` -- `$EDITOR`
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
aerospace/aerospace.toml     # AeroSpace window manager (workspaces, keybindings)
aerospace/borders.sh         # JankyBorders relaunch on appearance change
                             # Triggered by ~/Library/LaunchAgents/com.bheussler.borders-darknotify.plist
                             # (runs `dark-notify -c borders.sh`; not symlinked from this repo)
karabiner/karabiner.json     # Karabiner-Elements rules (caps → hyper)
ghostty/config               # Ghostty terminal config
git/gitconfig.symlink        # Git config (delta, GPG, aliases)
git/gitconfig.local.symlink  # Machine-local git config (credentials)
git/gitignore_global.symlink # Global gitignore
macos/set-defaults.sh        # macOS preferences (key repeat, Finder, etc.)
vim/vimrc.symlink            # Minimal vim config (fallback editor)
zed/settings.json            # Zed editor config
zsh/zshrc.symlink            # Shell entry point
```

## Workspace assignments

AeroSpace auto-assigns apps to workspaces on launch, keyed to the Dvorak left-hand home row (+ `M`):

| Key | Workspace | App |
|-----|-----------|-----|
| `A` | AI | Claude, Ollama |
| `O` | Obsidian | Obsidian |
| `E` | Editor | Zed |
| `U` | Utility | Ghostty |
| `I` | Internet | Safari |
| `D` | Default | scratch |
| `M` | Music | Spotify |

Messages floats instead of tiling. Switch with `hyper-<key>`, move the focused window with `alt-shift-<key>`.

## Install

```sh
git clone https://github.com/bheus/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This symlinks dotfiles into `$HOME`, installs Homebrew dependencies, and runs topic installers.

### Required: JankyBorders theme-switch LaunchAgent

The borders relaunch on appearance change is driven by a LaunchAgent that isn't symlinked from this repo. After bootstrap, create and load it:

```sh
cat > ~/Library/LaunchAgents/com.bheussler.borders-darknotify.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key><string>com.bheussler.borders-darknotify</string>
    <key>ProgramArguments</key>
    <array>
        <string>/opt/homebrew/bin/dark-notify</string>
        <string>-c</string>
        <string>$HOME/.dotfiles/aerospace/borders.sh</string>
    </array>
    <key>RunAtLoad</key><true/>
    <key>KeepAlive</key><true/>
</dict>
</plist>
EOF
launchctl load ~/Library/LaunchAgents/com.bheussler.borders-darknotify.plist
```

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
