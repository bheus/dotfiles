# Shell Refresh Migration Plan

Migrating from Antigen + oh-my-zsh + Agnoster to a modern, fast stack.

## New Stack

| Current | Replacement | Reason |
|---------|-------------|--------|
| Antigen + oh-my-zsh | Zinit | Actively maintained, lazy loading, 200-500ms faster startup |
| Agnoster theme | Starship | No framework dependency, same powerline feel, written in Rust |
| NVM via zsh-nvm | mise | Instant activation, handles Node/Ruby/Java/Python in one tool |
| jenv | mise | Same tool, eliminates a separate version manager |
| rbenv | mise | Same tool, eliminates a separate version manager |
| `z` + `fzf-z` | zoxide | Smarter frecency, built-in fzf integration |
| `ls` | eza | Colors, icons, git status, tree view |
| (new) | delta | Better git diffs |
| (new) | lazygit | Terminal git UI |

---

## Step 1 — Install new tools via Homebrew

Update `Brewfile`:

```
# Remove
brew 'antigen'
brew 'jenv'

# Add
brew 'zinit'
brew 'starship'
brew 'mise'
brew 'eza'
brew 'zoxide'
brew 'delta'
brew 'lazygit'
```

Then run:
```sh
brew bundle
```

---

## Step 2 — Replace Antigen with Zinit

**Delete** `zsh/antigen.zsh` and `zsh/antigenrc`.

**Create** `zsh/zinit.zsh`:

```zsh
# Initialize zinit
source $(brew --prefix)/opt/zinit/zinit.zsh

# Oh-my-zsh snippets — only load what we actually use
zi snippet OMZ::plugins/git/git.plugin.zsh
zi snippet OMZ::plugins/extract/extract.plugin.zsh
zi snippet OMZ::plugins/macos/macos.plugin.zsh
zi snippet OMZ::plugins/copypath/copypath.plugin.zsh
# Plugins
zi light zsh-users/zsh-autosuggestions
zi light zsh-users/zsh-syntax-highlighting
zi light Aloxaf/fzf-tab
```

> Note: `fzf-tab` replaces default tab completion with fzf — very nice quality of life upgrade.

> Docker: skip the OMZ docker snippet. Docker Desktop manages its own completions via `fpath=(/Users/bheussler/.docker/completions $fpath)` in `zshrc.symlink` — already in place and more up to date than the OMZ plugin.

---

## Step 3 — Replace Agnoster with Starship

**Create** `zsh/starship.zsh`:

```zsh
eval "$(starship init zsh)"
```

Starship auto-detects git status, language versions, etc. No extra config needed to get started, but it's highly customizable via `~/.config/starship.toml`.

**Update Ghostty font** in `ghostty/config` — Starship uses Nerd Font glyphs:

```
font-family = JetBrainsMono Nerd Font
font-size = 13
```

Install the font first:
```sh
brew install --cask font-jetbrains-mono-nerd-font
```

---

## Step 4 — Replace NVM, rbenv, jenv with mise

**Delete** `ruby/rbenv.zsh`.

**Create** `zsh/mise.zsh`:

```zsh
eval "$(mise activate zsh)"
```

Migrate existing runtimes:
```sh
# Node — check current version first
node --version
mise use --global node@<version>

# Ruby
ruby --version
mise use --global ruby@<version>

# Java (if needed)
mise use --global java@<version>
```

Remove old tools after confirming mise works:
```sh
brew uninstall jenv rbenv
# NVM can be removed after mise handles node
```

---

## Step 5 — Replace z/fzf-z with zoxide

Update `zsh/config.zsh`:

```zsh
setopt rmstarsilent
setopt extendedglob

# Replace z plugin with zoxide
eval "$(zoxide init zsh)"
```

Usage: `z` works as before, but `zi` opens an interactive fzf picker.

---

## Step 6 — Add eza aliases

**Create** `zsh/aliases.zsh`:

```zsh
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
```

---

## Step 7 — Configure delta for git diffs

Add to `git/gitconfig.symlink`:

```ini
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    light = false
    side-by-side = true

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
```

---

## Step 8 — Fix git editor

In `git/gitconfig.symlink`, change:

```ini
# Before
editor = vim

# After
editor = zed --wait
```

---

## What stays the same

- `zsh/zshrc.symlink` — structure is clean, no changes needed
- `zsh/fzf.zsh` — keep as-is
- `zsh/fpath.zsh` — keep as-is
- `system/_path.zsh` — keep as-is
- `system/env.zsh` — keep as-is
- `system/grc.zsh` — keep as-is
- All git config except `core.editor` and the delta additions
- Ghostty config except font

---

## Verification

After completing all steps, check startup time:
```sh
# Should be under 100ms with the new stack
time zsh -i -c exit
```
