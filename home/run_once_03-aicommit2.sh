#!/usr/bin/env bash
# chezmoi: run once — installs Node LTS (if missing) and aicommit2 globally via npm

[[ "$(uname)" == "Darwin" ]] || exit 0

# nvm is sourced in .zshrc (interactive only) — load it explicitly here
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && source "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/nvm.sh" ]    && source "/usr/local/opt/nvm/nvm.sh"

if ! command -v nvm &>/dev/null; then
  echo "[WARN] nvm not found — skipping. Run brew bundle first."
  exit 0
fi

if ! command -v node &>/dev/null; then
  echo "[INFO] Installing Node LTS…"
  nvm install --lts
  nvm alias default "lts/*"
  echo "[OK] Node $(node --version) installed."
fi

echo "[INFO] Installing aicommit2…"
npm install -g aicommit2
echo "[OK] aicommit2 installed. Set ANTHROPIC_API_KEY in ~/.zshrc.local to activate."
