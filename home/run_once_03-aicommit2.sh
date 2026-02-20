#!/usr/bin/env bash
# chezmoi: run once — installs aicommit2 globally via npm

# nvm is sourced in .zshrc (interactive only) — load it explicitly here
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && source "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/nvm.sh" ]    && source "/usr/local/opt/nvm/nvm.sh"

if command -v npm &>/dev/null; then
  echo "[INFO] Installing aicommit2…"
  npm install -g aicommit2
  echo "[OK] aicommit2 installed. Set ANTHROPIC_API_KEY in ~/.zshrc.local to activate."
else
  echo "[INFO] npm not found — skipping aicommit2. Run 'npm install -g aicommit2' after Node is set up."
fi
