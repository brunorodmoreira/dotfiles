# =============================================================================
# .zshenv — loaded for every zsh shell (interactive, non-interactive, login).
# PATH and env setup live here so tools that spawn non-interactive shells
# (Claude Code, CI, IDE integrations, subshells) can find binaries.
# Interactive-only config (aliases, plugins, prompt) lives in .zshrc.
# =============================================================================

# ---- zoxide doctor off ----
# Claude Code's Bash tool runs zsh -i, so .zshrc loads and zoxide's doctor
# trips on its invocation chain. Warning is cosmetic; silence it globally.
export _ZO_DOCTOR=0

# ---- PATH dedup ----
typeset -U path PATH

# ---- Locale / editor ----
export LANG=en_US.UTF-8
export EDITOR='nvim'

# ---- Homebrew bins (hardcoded for Apple Silicon; avoids brew shellenv shellout) ----
path=("/opt/homebrew/bin" "/opt/homebrew/sbin" $path)

# ---- Rust ----
. "$HOME/.cargo/env"

# ---- Node via fnm (default alias; interactive adds cd-hook via full fnm init in .zshrc) ----
path=("$HOME/.local/share/fnm/aliases/default/bin" $path)

# ---- bun ----
export BUN_INSTALL="$HOME/.bun"
path=("$BUN_INSTALL/bin" $path)

# ---- pnpm ----
export PNPM_HOME="$HOME/Library/pnpm"
path=("$PNPM_HOME" $path)

# ---- Flutter ----
path=("$HOME/flutter/bin" $path)

# ---- pipx / user-local bins ----
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)
