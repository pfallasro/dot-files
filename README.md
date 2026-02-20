# dot-files

Personal macOS dotfiles — shell, git, editor, and CLI configs.

## Quick reference

See [SHORTCUTS.md](./SHORTCUTS.md) for a full list of configured shortcuts and aliases across WezTerm, git, k9s, and shell tools.

## What's tracked

| Directory | Contents |
|---|---|
| `zsh/` | `.zshrc`, `.zprofile`, `.bash_profile` |
| `shell/` | `.p10k.zsh` (Powerlevel10k theme) |
| `git/` | `.gitconfig`, global gitignore |
| `vscode/` | `settings.json`, `keybindings.json`, `extensions.txt` |
| `brew/` | `Brewfile` (all taps, formulae, and casks) |
| `config/gh/` | GitHub CLI config |
| `config/wezterm/` | WezTerm terminal config (Night Owl theme) |
| `config/atuin/` | Atuin shell history config |
| `config/k9s/` | k9s Kubernetes TUI config |
| `config/helm/` | Helm repositories |

## New machine setup

```bash
# 1. Clone the repo
git clone https://github.com/pfallasro/dot-files.git ~/dot-files
cd ~/dot-files

# 2. Run the install script
./install.sh
```

The script will:
- Install Xcode CLI tools (if missing)
- Install Homebrew (if missing)
- Install all packages from `brew/Brewfile`
- Symlink all config files into the right places (backing up any existing files to `~/.dotfiles-backup/`)
- Install VSCode extensions from `vscode/extensions.txt`

## Machine-specific config

Work aliases, API keys, and anything you don't want public go in `~/.zshrc.local` — it's sourced automatically by `.zshrc` but excluded from the repo via `.gitignore`. Use `zsh/.zshrc.local.example` as a starting point:

```bash
cp ~/dot-files/zsh/.zshrc.local.example ~/.zshrc.local
# then edit ~/.zshrc.local with your actual values
```

## Post-install checklist

- [ ] Set your git email: `git config --global user.email you@example.com`
- [ ] Reload your shell: `source ~/.zshrc`
- [ ] Authenticate GitHub CLI: `gh auth login`
- [ ] Sign in to VSCode and sync settings (if using Settings Sync)
- [ ] Configure SSH key for git: generate with `ssh-keygen -t ed25519 -C "you@example.com"`, add to agent with `ssh-add ~/.ssh/id_ed25519`, then add the public key (`~/.ssh/id_ed25519.pub`) to your GitHub account
- [ ] Configure AWS auth: run `aws configure` (or set up SSO with `aws configure sso`) and verify with `aws sts get-caller-identity`

## Adding a new dotfile

1. Copy the file into the appropriate directory in this repo:
   ```bash
   cp ~/.config/foo/bar.conf config/foo/bar.conf
   ```
2. Add a `backup_and_link` line in `install.sh`:
   ```bash
   backup_and_link "$DOTFILES_DIR/config/foo/bar.conf" "$HOME/.config/foo/bar.conf"
   ```
3. Commit and push:
   ```bash
   git add . && git commit -m "Add foo config" && git push
   ```

## Updating existing files

Edit files through their symlinks as usual. Since the symlinks point into the repo, changes are immediately reflected. Then commit:

```bash
cd ~/dot-files
git add -p   # review what changed
git commit -m "Update <filename>"
git push
```

## Refreshing the Brewfile

```bash
brew bundle dump --file=brew/Brewfile --force
git add brew/Brewfile && git commit -m "Update Brewfile"
```
