# dotfiles

Personal macOS dotfiles for zsh, tmux, starship, atuin, and fnm. Managed as a
bare git repository so files live in-place in `$HOME` — no symlink farm, no
external tooling.

## What's in here

| File | Tool |
|---|---|
| `.zshenv` | zsh — env + PATH (loaded for **all** shells, incl. non-interactive) |
| `.zshrc` | zsh — interactive-only config (aliases, plugins, prompt) |
| `.zprofile` | zsh — login-shell stub (empty; setup lives in `.zshenv`) |
| `.tmux.conf` | tmux — terminal multiplexer |
| `.config/starship.toml` | starship — prompt |
| `.config/atuin/config.toml` | atuin — shell history |

## Install on a new machine

```bash
# 1) Clone bare
git clone --bare git@github.com:brunorodmoreira/dotfiles.git "$HOME/.dotfiles"

# 2) Temporary alias to drive checkout
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# 3) Checkout into $HOME. If files already exist, back them up:
mkdir -p "$HOME/.dotfiles-backup"
dot checkout 2>&1 | grep -E "^\s+\." | awk '{print $1}' | \
  xargs -I{} mv "$HOME/{}" "$HOME/.dotfiles-backup/{}"
dot checkout

# 4) Hide the rest of $HOME from `dot status`
dot config --local status.showUntrackedFiles no
```

After step 3, `.zshrc` is on disk — open a new shell and `dot` is available
(the alias is committed in `.zshrc`).

## Daily use

```bash
dot status              # show tracked, modified files
dot add ~/.some_rc      # start tracking a new dotfile
dot commit -m "..."     # commit
dot push                # push to GitHub
dot pull                # pull changes from another machine
```

## Prerequisites

Tools expected on PATH (install via Homebrew or native installers):
`zsh`, `tmux`, `starship`, `atuin`, `fnm`, `zoxide`, `fzf`, `eza`, `bat`,
`zsh-autosuggestions`, `zsh-syntax-highlighting`, `pyenv`, `bun`, `pnpm`.
