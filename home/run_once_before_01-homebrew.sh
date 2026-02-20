#!/usr/bin/env bash
# chezmoi: run once — installs Homebrew if missing

[[ "$(uname)" == "Darwin" ]] || exit 0

if ! command -v brew &>/dev/null; then
  echo "[INFO] Installing Homebrew…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  echo "[OK] Homebrew installed."
else
  echo "[OK] Homebrew already installed."
fi
