# =============================================================================
# .zshrc — interactive shells only.
# PATH and env setup live in .zshenv (loaded for ALL shells, including the
# non-interactive ones spawned by tools like Claude Code, CI, etc.).
# =============================================================================
[[ $- == *i* ]] || return

# ---- Keymap ----
# Force emacs keymap. Otherwise zsh's startup heuristic picks vi mode because
# $EDITOR contains "vi" (nvim), which leaves \e^? (Option+Delete) unbound and
# breaks Alt-prefixed shortcuts.
bindkey -e

# Treat / as a word boundary so Option+Delete kills path segments one at a time
# (matches the Claude Code TUI feel; default WORDCHARS includes /).
WORDCHARS="${WORDCHARS//\//}"

# ---- History ----
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

# ---- Version manager shell integration (hooks; PATH already set in .zshenv) ----
# fnm — adds the chpwd hook for auto-switch on .nvmrc / engines.node. Default
# alias bin already on PATH, so this layer is purely for cd-triggered switching.
eval "$(fnm env --use-on-cd --shell zsh --version-file-strategy recursive --corepack-enabled)"

# ---- Completion system ----
# Required for brew-installed tool completions in /opt/homebrew/share/zsh/site-functions.
# Must be loaded BEFORE any tool's completion eval (compdef is defined here).
autoload -Uz compinit && compinit

# ---- Completions for tools loaded above ----
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# uv — Python version selection is per-project via .python-version files
# (uv reads them natively); no shims/init needed, just completions.
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# ---- Plugins (autosuggestions BEFORE syntax-highlighting) ----
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- Aliases ----
alias code="code-insiders"
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --git'
alias la='eza -lah --icons --git'
alias cat='bat --paging=never'
alias g='git'
alias cd='z'
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# ---- Shell integrations ----
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide must be initialized last
eval "$(zoxide init zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export PATH="$HOME/.local/bin:$PATH"
