# Shortcuts & Aliases Reference

Quick reference for all configured tools. Use this when you forget something.

---

## WezTerm

| Shortcut | Action |
|---|---|
| `Cmd+F` | Search terminal output (your familiar find) |
| `Cmd+U` | Enter copy mode — vim-style scrollback search (`/` to search, `n/N` to jump, `y` to copy, `q` to exit) |
| `Cmd+K` | Clear scrollback |
| `Cmd+D` | Split pane horizontally |
| `Cmd+Shift+D` | Split pane vertically |
| `Cmd+[` / `Cmd+]` | Navigate between panes |
| `Cmd+Z` | Zoom current pane to full screen (toggle) |
| `Cmd+T` | New tab |
| `Cmd+W` | Close current tab |
| `Cmd+1-5` | Jump to tab by number |
| `Cmd+=` / `Cmd+-` | Increase / decrease font size |
| `Cmd+0` | Reset font size |

---

## Git Aliases

### Branch management
| Alias | Expands to | Description |
|---|---|---|
| `git co <branch>` | `checkout` | Switch branch |
| `git cob <branch>` | `checkout -b` | Create and switch to new branch |
| `git hotfix <name>` | `checkout -b hotfix/<name>` | Start a hotfix branch |
| `git release <version>` | `checkout -b release/<version>` | Start a release branch |
| `git brm <branch>` | | Delete branch locally and on remote |
| `git su <branch>` | | Set upstream for current branch |
| `git xclean` | | Delete all merged branches |
| `git done` | | Checkout main, pull, clean merged branches |

### Committing
| Alias | Expands to | Description |
|---|---|---|
| `git m "msg"` | `add . && commit -m` | Stage everything and commit |
| `git amn` | `commit --amend --no-edit` | Amend last commit without editing message |
| `git wip` | | Quick WIP commit of tracked changes |
| `git save` | | Savepoint commit (recoverable via reflog) |
| `git undo` | `reset HEAD~1 --mixed` | Undo last commit, keep changes staged |

### Staging (for breaking down commits)
| Alias | Expands to | Description |
|---|---|---|
| `git ap` | `add --patch` | Interactively stage hunks — use before `aicommit2` |

### Pushing / pulling
| Alias | Expands to | Description |
|---|---|---|
| `git p` | `push --set-upstream origin` | Push and set upstream in one step |
| `git pf` | `push --force-with-lease` | Safe force push |
| `git up` | `pull --rebase --prune` | Pull, rebase, prune dead remote branches |

### Tags & releases
| Alias | Description |
|---|---|
| `git tags` | List all tags, newest first |
| `git tg <version>` | Create annotated tag `v<version>` and push it |
| `git trm <version>` | Delete tag `v<version>` locally and on remote |
| `git changelog v1.0 v2.0` | List commits between two refs (release notes) |

### Stash
| Alias | Expands to | Description |
|---|---|---|
| `git ss "msg"` | `stash save` | Stash with a message |
| `git sp` | `stash pop` | Pop latest stash |
| `git sl` | `stash list` | List all stashes |

### Cherry-pick
| Alias | Description |
|---|---|
| `git cp <sha>` | Cherry-pick a commit |
| `git cpa` | Abort cherry-pick |
| `git cpc` | Continue cherry-pick after resolving conflicts |

### Inspection
| Alias | Description |
|---|---|
| `git st` | Short status with branch info |
| `git lg` | Pretty graph log (all branches) |
| `git ln` | Compact one-line log |
| `git last` | Last commit with files changed |
| `git files` | Files changed in last commit |
| `git recent` | Branches sorted by last activity |
| `git patch` | Plain diff (no color, for copy-pasting) |

### Misc
| Alias | Description |
|---|---|
| `git ec` | Open global gitconfig in editor |

---

## k9s

### Built-in navigation
| Key | Action |
|---|---|
| `:pods` / `:dp` / `:svc` | Jump to a resource view (use aliases below) |
| `/` | Filter resources by name |
| `Ctrl+Space` | Toggle namespace selector |
| `Enter` | Drill into a resource |
| `Esc` | Go back |
| `?` | Show all keybindings for current view |

### Resource aliases (configured)
| Alias | Resource |
|---|---|
| `dp` | deployments |
| `sts` | statefulsets |
| `ds` | daemonsets |
| `cj` | cronjobs |
| `jo` | jobs |
| `ing` | ingresses |
| `svc` | services |
| `np` | networkpolicies |
| `ep` | endpoints |
| `cm` | configmaps |
| `sec` | secrets |
| `pvc` | persistentvolumeclaims |
| `pv` | persistentvolumes |
| `sc` | storageclasses |
| `ns` | namespaces |
| `no` | nodes |
| `ev` | events |
| `sa` | serviceaccounts |
| `hpa` | horizontalpodautoscalers |
| `pdb` | poddisruptionbudgets |
| `cr` | clusterroles |
| `crb` | clusterrolebindings |
| `ro` | roles |
| `rb` | rolebindings |

### Pod actions
| Key | Action |
|---|---|
| `l` | View logs |
| `s` | Shell into container |
| `d` | Describe resource |
| `ctrl+k` | Delete / kill pod |
| `shift+f` | Port forward |
| `y` | View raw YAML |
| `e` | Edit resource |
| `ctrl+d` | Delete resource |

### Logs view
| Key | Action |
|---|---|
| `/` | Search log output |
| `f` | Toggle full-screen |
| `w` | Toggle text wrap |
| `t` | Toggle timestamps |
| `0` | Show all containers |

---

## Shell (Zsh)

### Atuin (shell history)
| Shortcut | Action |
|---|---|
| `Ctrl+R` | Fuzzy search full shell history (much better than default) |
| `Up arrow` | Search history prefix (standard) |

### fzf
| Shortcut | Action |
|---|---|
| `Ctrl+T` | Fuzzy find files and paste path into command |
| `Ctrl+R` | Fuzzy search history (overridden by Atuin) |

### Zoxide (smart cd)
| Command | Action |
|---|---|
| `cd <partial>` | Jump to most frecent matching directory |
| `cd -` | Go back to previous directory |

### Keybindings
| Shortcut | Action |
|---|---|
| `Ctrl+P` | Search history backward |
| `Ctrl+N` | Search history forward |
| `Ctrl+W` | Kill word (delete word before cursor) |

---

## aicommit2

| Command | Action |
|---|---|
| `aicommit2` | Generate conventional commit message from staged changes |

**Recommended workflow for clean commits:**
```bash
git ap          # stage only the hunks for commit #1
aicommit2       # pick from 3 AI-generated conventional commit options
git ap          # stage next logical chunk
aicommit2       # repeat
```

---

## Useful CLI one-liners for your role

```bash
# Tail logs across all pods in a deployment (stern)
stern <deployment-name> -n <namespace>

# Generate a changelog between two tags (git-cliff)
git cliff v1.0.0..v2.0.0

# Watch a GitHub Actions run
gh run watch

# Port-forward a service locally
kubectl port-forward svc/<name> 8080:80 -n <namespace>

# Get all failing pods across all namespaces
kubectl get pods -A --field-selector=status.phase!=Running

# Decode a secret value
kubectl get secret <name> -o jsonpath='{.data.<key>}' | base64 -d
```
