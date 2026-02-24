#!/usr/bin/env bash
# chezmoi: run when this script changes — installs Node LTS via nvm if missing

[[ "$(uname)" == "Darwin" ]] || exit 0

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && source "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/nvm.sh" ]    && source "/usr/local/opt/nvm/nvm.sh"

if ! command -v nvm &>/dev/null; then
  echo "[WARN] nvm not found — skipping Node install. Run brew bundle first."
  exit 0
fi

if nvm ls --no-alias | grep -q "v"; then
  echo "[OK] Node already installed: $(node --version)"
else
  echo "[INFO] Installing Node LTS…"
  nvm install --lts
  nvm alias default "lts/*"
  echo "[OK] Node $(node --version) installed and set as default."
fi
