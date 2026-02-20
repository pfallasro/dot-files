eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv — manages Python versions
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
