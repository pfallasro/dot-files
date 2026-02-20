#!/usr/bin/env bash
# chezmoi: run once — installs kubectl krew plugins

# Homebrew and krew bin are not in PATH in non-interactive scripts
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

if ! command -v kubectl-krew &>/dev/null; then
  echo "[INFO] krew not found — skipping plugin install."
  exit 0
fi

plugins=(
  neat               # clean up kubectl output (removes managed fields, status noise)
  resource-capacity  # node/pod CPU and memory usage at a glance
  who-can            # RBAC auditing — who can do what on which resource
)

for plugin in "${plugins[@]}"; do
  if kubectl krew list 2>/dev/null | grep -q "^${plugin}$"; then
    echo "[OK] krew plugin already installed: ${plugin}"
  else
    echo "[INFO] Installing krew plugin: ${plugin}"
    kubectl krew install "${plugin}"
  fi
done

echo "[OK] krew plugins ready."
