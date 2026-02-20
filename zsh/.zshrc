# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew (needed for non-login shells)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::terraform
zinit snippet OMZP::github
zinit snippet OMZP::encode64

# Go
export GOPATH=$HOME/go
export PATH="$PATH:${GOPATH}/bin"

# Load completions with caching (speeds up subsequent loads)
autoload -Uz compinit
# Only regenerate compdump once per day
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit -i
else
  compinit -C -i
fi

# Tool completions
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi

if command -v docker &> /dev/null; then
  source <(docker completion zsh)
fi

if command -v gh &> /dev/null; then
  source <(gh completion -s zsh)
fi

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^[[A' history-beginning-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'

# Machine-specific / work config (not committed)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# PATH additions
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"   # krew (kubectl plugin manager)
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# asdf (multi-language version manager — handles runtime installs)
if [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
  source "/opt/homebrew/opt/asdf/libexec/asdf.sh"
elif [[ -f "/usr/local/opt/asdf/libexec/asdf.sh" ]]; then
  source "/usr/local/opt/asdf/libexec/asdf.sh"
fi
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# nvm (Node version manager) — supports both Apple Silicon and Intel
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# Terraform completion (uses whichever version tfenv has active)
autoload -U +X bashcompinit && bashcompinit
if command -v terraform &>/dev/null; then
  complete -o nospace -C "$(which terraform)" terraform
fi

export LC_ALL=en_US.UTF-8
export XDG_CONFIG_HOME="${HOME}/.config"

export PATH="/opt/homebrew/opt/postgresql/bin:$PATH"
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# Prioritize GOPATH bin for locally built binaries
export PATH="${GOPATH}/bin:$PATH"
