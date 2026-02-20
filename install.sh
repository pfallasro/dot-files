#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# ─── Helpers ──────────────────────────────────────────────────────────────────

info()    { echo "[INFO]  $*"; }
success() { echo "[OK]    $*"; }
error()   { echo "[ERROR] $*" >&2; exit 1; }

backup_and_link() {
  local src="$1"   # absolute path inside repo
  local dest="$2"  # absolute path in ~

  mkdir -p "$(dirname "$dest")"

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "${dest#$HOME/}")"
    mv "$dest" "$BACKUP_DIR/${dest#$HOME/}"
    info "Backed up $dest → $BACKUP_DIR/${dest#$HOME/}"
  fi

  ln -sf "$src" "$dest"
  success "Linked $dest → $src"
}

# ─── 1. macOS check ───────────────────────────────────────────────────────────

[[ "$(uname)" == "Darwin" ]] || error "This script is macOS-only."

# ─── 2. Xcode CLI tools ───────────────────────────────────────────────────────

if ! xcode-select -p &>/dev/null; then
  info "Installing Xcode Command Line Tools…"
  xcode-select --install
  # Wait for the installation to finish
  until xcode-select -p &>/dev/null; do sleep 5; done
  success "Xcode CLI tools installed."
else
  success "Xcode CLI tools already installed."
fi

# ─── 3. Homebrew ──────────────────────────────────────────────────────────────

if ! command -v brew &>/dev/null; then
  info "Installing Homebrew…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for Apple Silicon
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  success "Homebrew installed."
else
  success "Homebrew already installed."
fi

# ─── 4. Brew bundle ───────────────────────────────────────────────────────────

info "Installing packages from Brewfile…"
brew bundle --file="$DOTFILES_DIR/brew/Brewfile"
success "Brew bundle complete."

# ─── 5. Symlinks ──────────────────────────────────────────────────────────────

info "Creating symlinks (backups in $BACKUP_DIR)…"

backup_and_link "$DOTFILES_DIR/zsh/.zshrc"                    "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/zsh/.zprofile"                  "$HOME/.zprofile"
backup_and_link "$DOTFILES_DIR/zsh/.bash_profile"              "$HOME/.bash_profile"
backup_and_link "$DOTFILES_DIR/shell/.p10k.zsh"                "$HOME/.p10k.zsh"
backup_and_link "$DOTFILES_DIR/git/.gitconfig"                 "$HOME/.gitconfig"
backup_and_link "$DOTFILES_DIR/git/config/git/ignore"          "$HOME/.config/git/ignore"
backup_and_link "$DOTFILES_DIR/config/gh/config.yml"           "$HOME/.config/gh/config.yml"
backup_and_link "$DOTFILES_DIR/config/atuin/config.toml"       "$HOME/.config/atuin/config.toml"
backup_and_link "$DOTFILES_DIR/config/k9s/config.yaml"              "$HOME/.config/k9s/config.yaml"
backup_and_link "$DOTFILES_DIR/config/k9s/aliases.yaml"             "$HOME/.config/k9s/aliases.yaml"
backup_and_link "$DOTFILES_DIR/config/k9s/views.yaml"               "$HOME/.config/k9s/views.yaml"
backup_and_link "$DOTFILES_DIR/config/k9s/skins/night-owl.yaml"     "$HOME/.config/k9s/skins/night-owl.yaml"
backup_and_link "$DOTFILES_DIR/config/helm/repositories.yaml"  "$HOME/.config/helm/repositories.yaml"
backup_and_link "$DOTFILES_DIR/config/aicommit2/.aicommit2"    "$HOME/.aicommit2"
backup_and_link "$DOTFILES_DIR/config/wezterm/wezterm.lua"     "$HOME/.config/wezterm/wezterm.lua"
backup_and_link "$DOTFILES_DIR/vscode/settings.json"           "$HOME/Library/Application Support/Code/User/settings.json"
backup_and_link "$DOTFILES_DIR/vscode/keybindings.json"        "$HOME/Library/Application Support/Code/User/keybindings.json"

# ─── 6. aicommit2 ────────────────────────────────────────────────────────────

if command -v npm &>/dev/null; then
  info "Installing aicommit2…"
  npm install -g aicommit2
  success "aicommit2 installed. Set ANTHROPIC_API_KEY in your environment to activate."
else
  info "npm not found — skipping aicommit2 install. Run 'npm install -g aicommit2' after setting up Node."
fi

# ─── 7. VSCode extensions ─────────────────────────────────────────────────────

if command -v code &>/dev/null; then
  info "Installing VSCode extensions…"
  while IFS= read -r ext; do
    [[ -z "$ext" || "$ext" == \#* ]] && continue
    code --install-extension "$ext" --force
  done < "$DOTFILES_DIR/vscode/extensions.txt"
  success "VSCode extensions installed."
else
  info "VSCode CLI (code) not found — skipping extension install."
  info "Install VSCode and re-run, or install extensions manually from vscode/extensions.txt."
fi

# ─── 8. Next steps ────────────────────────────────────────────────────────────

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║               Setup complete! Next steps:            ║"
echo "╠══════════════════════════════════════════════════════╣"
echo "║  1. Set your git email:                              ║"
echo "║     git config --global user.email you@example.com  ║"
echo "║                                                      ║"
echo "║  2. Reload your shell:                               ║"
echo "║     source ~/.zshrc                                  ║"
echo "║                                                      ║"
echo "║  3. Authenticate GitHub CLI:                         ║"
echo "║     gh auth login                                    ║"
echo "║                                                      ║"
echo "║  4. Set your Anthropic API key for aicommit2:        ║"
echo "║     export ANTHROPIC_API_KEY=sk-ant-...             ║"
echo "╚══════════════════════════════════════════════════════╝"
