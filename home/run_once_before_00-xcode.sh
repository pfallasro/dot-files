#!/usr/bin/env bash
# chezmoi: run once — installs Xcode Command Line Tools if missing

[[ "$(uname)" == "Darwin" ]] || exit 0

if ! xcode-select -p &>/dev/null; then
  echo "[INFO] Installing Xcode Command Line Tools…"
  xcode-select --install || true   # exits 1 when triggering the GUI dialog — ignore it
  echo "[INFO] Waiting for Xcode CLI tools installation to complete (click Install in the dialog)…"
  until xcode-select -p &>/dev/null; do sleep 5; done
  echo "[OK] Xcode CLI tools installed."
else
  echo "[OK] Xcode CLI tools already installed."
fi
