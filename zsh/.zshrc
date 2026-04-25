# =============================================================================
# ~/.zshrc — managed by ~/dotfiles (stowed)
# =============================================================================

# Homebrew --------------------------------------------------------------------
# Apple Silicon Homebrew lives in /opt/homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# History ---------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY

# Completion ------------------------------------------------------------------
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Plugins ---------------------------------------------------------------------
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# fzf -------------------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide (smarter cd) ---------------------------------------------------------
eval "$(zoxide init zsh)"

# Aliases ---------------------------------------------------------------------
# Modern replacements
alias ls='eza --icons'
alias ll='eza -lah --icons --git'
alias lt='eza --tree --level=2 --icons'
alias cat='bat --paging=never'
alias find='fd'
alias grep='rg'

# Git
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gp='git push'
alias gl='git log --oneline --graph --decorate -20'
alias gco='git checkout'
alias gb='git branch'

# Docker
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias lzd='lazydocker'

# Kubernetes
alias k='kubectl'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias dotfiles='cd ~/dotfiles'
alias homelab='cd ~/code/homelab'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Quick edits
alias zshrc='${EDITOR:-vim} ~/.zshrc'
alias reload='source ~/.zshrc'

# Network / homelab
alias myip='curl -s ifconfig.me; echo'
alias localip="ipconfig getifaddr en0"
alias pi5='ssh hicloud@192.168.1.144'

# AWS / Cloud
alias awswho='aws sts get-caller-identity'

# Editor ----------------------------------------------------------------------
export EDITOR='code -w'
export VISUAL='code -w'

# Path additions --------------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"

# pyenv -----------------------------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"

# nvm -------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"

# Starship prompt (must be at end) --------------------------------------------
eval "$(starship init zsh)"
