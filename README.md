# dotfiles

macOS development environment, managed with [chezmoi](https://chezmoi.io).

fish · ghostty · starship · atuin · zoxide · neovim · tmux

## Quick start

```sh
brew install chezmoi
chezmoi init Ostralyan/dotfiles   # clones + asks for your name and email
chezmoi diff                      # see exactly what would change in $HOME
chezmoi apply                     # write it
```

`chezmoi init` does **not** touch your home directory. Nothing is written until
`chezmoi apply`, so always read the diff first — this will overwrite configs you
already have.

Prefer something that walks you through it, including Homebrew, the packages and
the login shell? Use the guided script in the didero repo:

```sh
~/didero/scripts/setup-dotfiles.sh
```

Then **open Ghostty**, not Terminal.app. The theme, the nerd font and the cursor
shader only apply there.

## The two questions

| Prompt | What it does |
|---|---|
| Full name for git commits | Fills `[user] name` in `~/.config/git/config` |
| Email for git commits | Fills `[user] email` — use your didero address |

That's the whole setup. Answers are stored in `~/.config/chezmoi/chezmoi.toml`,
which is never committed. To change them later, edit that file or re-run
`chezmoi init`.

## What you get

| | |
|---|---|
| `fish` | shell config, completions, `wtcd`, `setup_brew_packages` |
| `starship` | prompt |
| `atuin` | searchable shell history |
| `nvim` | full config; lazy.nvim bootstraps itself on first launch |
| `ghostty` | catppuccin theme, nerd font, cursor shader |
| `tmux` | config + TPM (`ctrl-b` then `I` on first run to install plugins) |
| `git` | aliases (`lg`, `co`, `cax`, `aic`, `loc`, ...) and a global ignore |
| `bat`, `eza`, `fzf` | catppuccin themes |

## The personal rig (off by default, ignore this)

The repo also carries a single-machine macOS window-manager setup — `aerospace`,
`sketchybar`, `karabiner` and `harp`. It is tied to one specific monitor layout,
you are never asked about it, and it is **never written** unless you go out of
your way to turn it on.

If you actually want it:

```sh
DOTFILES_PERSONAL=1 chezmoi init Ostralyan/dotfiles
```

or set `personal = true` under `[data]` in `~/.config/chezmoi/chezmoi.toml` and
run `chezmoi apply`. That also unlocks `Brewfile.rig` and `Brewfile.apps`. Once
set it stays set, including across re-runs of `chezmoi init`.

## Packages

Brewfiles land in `~/.config/homebrew/`:

| File | Contents | Installed when |
|---|---|---|
| `Brewfile` | shell, CLI, editor, didero backend toolchain | always |
| `Brewfile.rig` | aerospace, sketchybar, karabiner | `personal = true` |
| `Brewfile.apps` | personal apps and side-project toolchain | `personal = true` |

```sh
setup_brew_packages          # installs every Brewfile present
brew bundle check --file=~/.config/homebrew/Brewfile   # what's missing
```

## Day to day

```sh
chezmoi diff                 # what would change in $HOME
chezmoi apply                # take the latest
chezmoi update               # git pull, then apply
chezmoi add    ~/.config/foo # start tracking a file
chezmoi re-add               # pull local edits back into the repo
chezmoi status               # anything drifted?
cm                           # aliased to chezmoi
```

Edit files in `$HOME` as usual, then `chezmoi re-add` to capture the change.
Commit and push from the source directory (`chezmoi cd`).

## Layout

```
.chezmoi.toml.tmpl        the three init prompts
.chezmoiignore            templated; hides the personal rig when personal = false
.chezmoiexternal.toml     TPM and the ghostty cursor shaders
private_dot_config/       everything under ~/.config
```

Anything machine-local — `fish_variables`, `gh/hosts.yml`, sketchybar's
runtime caches — is deliberately untracked. Don't `chezmoi add` it back.
