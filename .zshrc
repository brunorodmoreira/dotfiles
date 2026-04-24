# =============================================================================
# .zshrc — interactive shells only.
# PATH and env setup live in .zshenv (loaded for ALL shells, including the
# non-interactive ones spawned by tools like Claude Code, CI, etc.).
# =============================================================================
[[ $- == *i* ]] || return

# ---- History ----
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

# ---- Version manager shell integration (hooks; PATH already set in .zshenv) ----
# pyenv — installs the rehash hook and shell functions. Shims already on PATH.
eval "$(pyenv init - zsh)"

# fnm — adds the chpwd hook for auto-switch on .nvmrc / engines.node. Default
# alias bin already on PATH, so this layer is purely for cd-triggered switching.
eval "$(fnm env --use-on-cd --shell zsh --version-file-strategy recursive --corepack-enabled)"

# ---- Completion system ----
# Required for brew-installed tool completions in /opt/homebrew/share/zsh/site-functions.
autoload -Uz compinit && compinit

# ---- Completions for tools loaded above ----
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

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
