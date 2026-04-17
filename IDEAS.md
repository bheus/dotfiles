# Ideas for Future Consideration

Audit notes captured 2026-04-17. Not a to-do list — a menu to pick from.

## Cleanup (low risk, high polish)

- **Empty `.gitmodules`** (0 bytes) — remove.
- **`htop` + `btop`** — pick one (both still in Brewfile).
- **`GitHub Desktop.app`** — likely redundant with `lazygit` + `gh` + Zed's git panel.
- **`Capital One Shopping.app`** — almost certainly a drive-by install.
- **`Logi Tune.app`** — keep only if you actively tune Logitech peripherals; otherwise it runs a background helper for nothing.
- **`.gitignore` still lists `cache/`** — harmless now that the dir is gone, but could be dropped.

## gitconfig polish

- `push.default = simple` has been the git default since 2.0 — can remove.
- `help.autocorrect = 1` auto-runs the corrected command after 0.1s. `prompt` is safer if you've ever been bitten.

## Ghostty

- `window-save-state = default` is a no-op (that's the default). Can remove.

## Biggest single gap: Brewfile reproducibility

**`mas`** (Mac App Store CLI) — your Brewfile reproduces the CLI stack but none of the App Store apps (1Password, Bartender, Shottr, etc.). With `mas`, a fresh machine is one `brew bundle` away from fully restored.

```ruby
brew 'mas'
mas '1Password 7', id: 1333542190
# etc.
```

## Measurement / quality tooling

- **`hyperfine`** — the README sets a "under 250ms" shell-startup target but nothing measures it. `hyperfine 'zsh -i -c exit'` closes the loop.
- **`shellcheck` + `shfmt`** — you have a real `bin/` and per-topic `install.sh` scripts. No linter/formatter today.

## Completing the "modern coreutils" set

You've committed to eza/bat/fd/ripgrep/delta/zoxide. The peer-group you're missing:

- **`dust`** — `du` replacement, tree-style disk usage.
- **`duf`** — `df` replacement, readable disk summary.
- **`procs`** — `ps` replacement, color + tree.
- **`sd`** — simpler find/replace than `sed` for common cases.

## Workflow upgrades

- **`atuin`** — syncable, fzf-searchable shell history. Major upgrade to Ctrl-R. Fits your fzf-heavy setup.
- **`git-absorb`** — auto-fixup commits into the right parent. The missing third leg alongside delta/difftastic for a git power-user setup.
- **`watchexec`** — modern file-watcher for "run X on change" workflows.
- **`gum`** (Charm) — polish your `bin/` scripts with prompts/spinners. Same family as `glow`.

## If/when you touch Python

- **`uv`** — modern project/package manager. mise handles the runtime; `uv` handles everything else. Increasingly standard.
- **`ruff`** — linter + formatter. Extremely fast, now the de-facto choice.

## If you want an HTTP client

TablePlus covers SQL but you have no API tool.

- **`httpie`** — CLI, minimal.
- **`bruno`** — GUI, open-source Postman alternative.

## GUI apps: strongest fit for this setup

- **SketchyBar** — same author as JankyBorders (`FelixKratz/formulae`), same ecosystem. AeroSpace + JankyBorders + SketchyBar is the canonical macOS-tiling trio; you're 2 of 3 already. Adds a real status bar (workspace indicator, battery, time, anything scriptable).
- **Tailscale** — given OrbStack + dev-heavy setup, this unlocks reaching your Mac's containers/services from other devices over a private WireGuard net. Pairs with 1Password SSH + `op` for key management.

## GUI apps: likely gaps

- **Calendar** — nothing beyond Apple Calendar. **Notion Calendar** (free, was Cron) or **Fantastical** (paid). Notion Calendar's keyboard-driven scheduling pairs well if you live in Obsidian.
- **Read-later / highlights** — **Readwise Reader** auto-syncs highlights into Obsidian. Biggest vault-quality upgrade for people already using Obsidian.
- **Screen recording** — Shottr covers screenshots but not video. **CleanShot X** (paid) is the upgrade (screenshot + recording + GIF + cloud). **Kap** (free, open source) for GIFs only.
- **Communication apps** — no Slack/Discord/Zoom/Teams visible. If this is intentional, skip; otherwise install proper apps rather than PWAs.
- **Raycast consideration** — not a gap since you have Alfred 5, but Raycast has pulled ahead on LLM integration (Claude/ChatGPT commands), free extension store, and built-in clipboard/snippets. Worth a trial; keep Alfred if Powerpack workflows matter.

## GUI app pairings worth wiring up

- **Obsidian + Readwise** — automatic highlight sync from articles/books into your vault.
- **Alfred + `op`** — Alfred workflows can call the 1Password CLI to fill credentials into non-browser contexts.
- **Karabiner + Homerow** — Homerow is keyboard-driven mouse control (click any UI element). Your caps→hyper setup makes the trigger trivial.
- **Shottr + Raycast/Alfred hotkey chains** — standardize a screenshot→annotate→upload flow.

## Performance / reproducibility nits

- `ollama` + `qwen2.5-coder:3b` is pinned in Zed settings but not installed via Brewfile. Add it for reproducibility if you rely on the Zed agent.
- Once `mas` is in, audit `/Applications` vs Brewfile and promote everything installable.
