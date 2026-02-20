# dot-files

Personal macOS dotfiles — shell, git, editor, and CLI configs, managed with [chezmoi](https://www.chezmoi.io/).

## Quick reference

See [SHORTCUTS.md](./SHORTCUTS.md) for a full list of configured shortcuts and aliases across WezTerm, git, k9s, and shell tools.

## Repository structure

```
dot-files/
├── home/                    ← chezmoi source root (set via .chezmoiroot)
│   ├── dot_zshrc            ← ~/.zshrc (symlinked — edit in place)
│   ├── dot_zprofile         ← ~/.zprofile
│   ├── dot_bash_profile     ← ~/.bash_profile
│   ├── dot_p10k.zsh         ← ~/.p10k.zsh (Powerlevel10k theme)
│   ├── dot_gitconfig.tmpl   ← ~/.gitconfig (name/email prompted on first apply, copied)
│   ├── dot_aicommit2        ← ~/.aicommit2
│   ├── dot_config/          ← ~/.config/ (gh, atuin, k9s, wezterm, helm)
│   ├── run_once_before_*/   ← bootstrap: Xcode CLI tools, Homebrew
│   ├── run_onchange_*/      ← re-run when content changes: brew bundle, VSCode
│   ├── brew/Brewfile        ← all taps, formulae, and casks
│   └── vscode/              ← settings.json, keybindings.json (extensions via Brewfile)
├── README.md
└── SHORTCUTS.md
```

The `dot_` prefix is a [chezmoi naming convention](https://www.chezmoi.io/reference/source-state-attributes/) — it maps to a dotfile in `$HOME`. All files are **symlinked** back to the source by default (`mode = "symlink"` in `.chezmoi.toml.tmpl`), except `.tmpl` files which are rendered and copied.

## New machine setup

```bash
# One command — installs chezmoi, clones this repo, and applies everything
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/pfallasro/dot-files
```

chezmoi will prompt for your name and git email on first run, then:
- Install Xcode CLI tools (if missing)
- Install Homebrew (if missing)
- Install all packages from `brew/Brewfile`
- Symlink all dotfiles into the right places
- Copy VSCode settings (extensions installed via Brewfile)

## Machine-specific config

Work aliases, API keys, and anything you don't want public go in `~/.zshrc.local` — sourced automatically by `.zshrc` but excluded from the repo via `.gitignore`.

## Post-install checklist

- [ ] Set your git email: `git config --global user.email you@example.com`
- [ ] Reload your shell: `source ~/.zshrc`
- [ ] Authenticate GitHub CLI: `gh auth login`
- [ ] Log in to Atuin for cross-machine history sync: `atuin login` (or `atuin register` for a new account)
- [ ] Sign in to VSCode and sync settings (if using Settings Sync)
- [ ] Configure SSH key for git: generate with `ssh-keygen -t ed25519 -C "you@example.com"`, add to agent with `ssh-add ~/.ssh/id_ed25519`, then add the public key (`~/.ssh/id_ed25519.pub`) to your GitHub account
- [ ] Configure AWS auth: run `aws configure` (or set up SSO with `aws configure sso`) and verify with `aws sts get-caller-identity`

## Adding a new dotfile

```bash
chezmoi add ~/.config/foo/bar.conf   # registers file with chezmoi
chezmoi cd                           # jump to source dir
git add -p && git commit -m "Add foo config" && git push
```

## Updating existing files

Dotfiles are **symlinked** — edit them in place as usual (`~/.zshrc`, etc.) and changes are immediately reflected in the source directory.

```bash
chezmoi cd
git add -p && git commit -m "Update <filename>"
git push
```

To pull and apply changes on another machine:

```bash
chezmoi update   # git pull + apply in one step
```

## Refreshing the Brewfile

```bash
brew bundle dump --file=home/brew/Brewfile --force
git add home/brew/Brewfile && git commit -m "Update Brewfile"
git push
# chezmoi will re-run brew bundle automatically on next 'chezmoi update'
```

## Current machine setup (one-time, if repo already cloned)

```bash
brew install chezmoi
chezmoi init --source="$HOME/Documents/personal/repos/dot-files"
chezmoi apply
```
