# Git Configuration

> 🇷🇺 [Русская версия](README.ru.md)

This directory contains Git configuration for the dotfiles repository.

## Overview

Git configuration with integrated secret management via KeePassXC and enhanced diff/merge tools.

## Files

- `config.tmpl` - Main Git configuration (chezmoi template)
- `ignore` - Global gitignore patterns

## Features

### KeePassXC Integration

Secrets are managed securely through KeePassXC and injected via chezmoi templates:

```toml
# .chezmoi.toml.tmpl
[keepassxc]
  database = "~/Library/Mobile Documents/com~apple~CloudDocs/Secrets/vaults/secrets.kdbx"
```

The `config.tmpl` uses chezmoi's KeePassXC integration to fetch secrets:

```git
[user]
  name = {{ (keepassxcAttribute "Git" "username").Text }}
  email = {{ (keepassxcAttribute "Git" "email").Text }}

[github]
  user = {{ (keepassxcAttribute "GitHub" "username").Text }}
  token = {{ (keepassxcAttribute "GitHub" "token").Text }}
```

**Stored secrets:**
- Git username and email
- GitHub username and token
- GitLab username and token
- GPG signing key

### Enhanced Diff Tool

Uses [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy) for beautiful, readable diffs:

```git
[core]
  pager = diff-so-fancy | less --tabs=4 -RFX
```

**Features:**
- Syntax highlighting
- Better formatting
- Improved readability
- File headers with clear separation

### Custom Merge Tool

Configured to use Neovim with 3-way diff view:

```git
[merge]
  tool = nvim
  conflictstyle = diff3

[mergetool "nvim"]
  cmd = nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'
```

**Benefits:**
- Visual 3-way merge
- Familiar vim keybindings
- Efficient conflict resolution
- Shows base, local, and remote versions

### Global Gitignore

The `ignore` file contains patterns for project-specific files that should be excluded globally:

```gitignore
.mise.toml                        # Project-specific mise tool versions
**/.claude/settings.local.json    # Local Claude Code settings
```

These patterns exclude:
- **`.mise.toml`** - Per-project tool version overrides (personal development setup)
- **`.claude/settings.local.json`** - Local Claude Code configuration (machine-specific)

**Configured in git:**
```git
[core]
  excludesfile = ~/.config/git/ignore
```

## Configuration Highlights

### User Settings

```git
[user]
  name = Your Name (from KeePassXC)
  email = your.email@example.com (from KeePassXC)
  signingkey = GPG_KEY_ID (from KeePassXC)

[commit]
  gpgsign = true  # Sign all commits with GPG
```

### Core Settings

```git
[core]
  editor = nvim
  autocrlf = input  # Normalize line endings
  whitespace = trailing-space,space-before-tab
  pager = diff-so-fancy | less --tabs=4 -RFX
```

### Aliases

Common Git aliases for productivity:

```git
[alias]
  st = status -sb
  co = checkout
  br = branch
  ci = commit
  unstage = reset HEAD --
  last = log -1 HEAD
  visual = log --graph --oneline --all
```

### Push/Pull Behavior

```git
[push]
  default = current        # Push current branch to same name
  followTags = true        # Push tags with commits

[pull]
  rebase = true           # Rebase instead of merge on pull
  ff = only               # Fast-forward only
```

### Rebase Settings

```git
[rebase]
  autoStash = true        # Automatically stash changes
  autoSquash = true       # Auto-squash fixup commits
```

### Diff Settings

```git
[diff]
  tool = nvimdiff
  algorithm = patience    # Better diff algorithm
  colorMoved = zebra      # Highlight moved lines

[diff "bin"]
  textconv = hexdump -v -C  # Show binary diffs in hex
```

## Usage

### Viewing Configuration

```bash
# Show all git config
git config --list

# Show config from specific file
git config --file ~/.config/git/config --list

# Show specific value
git config user.name
```

### Using diff-so-fancy

```bash
# View diff with diff-so-fancy
git diff

# Compare branches
git diff main..feature

# Show commit changes
git show HEAD
```

### Using Neovim Merge Tool

```bash
# When conflicts occur
git merge feature-branch

# Open merge tool
git mergetool

# In Neovim:
# - Left window: LOCAL (your changes)
# - Center window: BASE (common ancestor)
# - Right window: REMOTE (incoming changes)
# - Bottom window: MERGED (result)
```

**Neovim merge commands:**
- `:diffget LOCAL` - Get changes from local version
- `:diffget REMOTE` - Get changes from remote version
- `:diffget BASE` - Get changes from base version
- `:wqa` - Save and exit all windows

### Managing Secrets

Secrets are automatically loaded from KeePassXC when running:

```bash
chezmoi apply
```

**To update secrets:**
1. Update entry in KeePassXC
2. Run `chezmoi apply` to regenerate `~/.config/git/config`
3. Verify with `git config user.email`

### Adding Global Ignores

Edit `~/.config/git/ignore`:

```bash
chezmoi edit ~/.config/git/ignore
```

Or directly:

```bash
echo "*.log" >> ~/.config/git/ignore
```

## Integration

### With Fish Shell

Fish shell includes Git abbreviations and functions:
- `gb` - List branches
- `gco` - Checkout
- `gp` - Push
- `gl` - Pull
- See `dot_config/fish/config.fish.tmpl` for full list

### With LazyGit

LazyGit respects git configuration:
- Uses diff-so-fancy for diffs
- Honors GPG signing settings
- Uses configured editor

### With Chezmoi

Git config is managed by chezmoi:
- Template processed on `chezmoi apply`
- Secrets injected from KeePassXC
- Changes tracked in dotfiles repository

## Troubleshooting

### Secrets Not Loading

- Ensure KeePassXC database is unlocked
- Verify database path in `.chezmoi.toml.tmpl`
- Check entry names match in KeePassXC
- Run `chezmoi apply -v` for verbose output

### diff-so-fancy Not Working

- Verify installation: `which diff-so-fancy`
- Check mise installation: `mise ls | grep diff-so-fancy`
- Reinstall: `mise install ubi:so-fancy/diff-so-fancy`

### Merge Tool Not Opening

- Verify Neovim is installed: `which nvim`
- Check git config: `git config merge.tool`
- Try manual merge: `git mergetool --tool=nvim`

### GPG Signing Fails

- Check GPG key: `gpg --list-secret-keys`
- Verify signing key: `git config user.signingkey`
- Test signing: `echo "test" | gpg --sign`

## Security Notes

- Never commit the generated `~/.config/git/config` file (contains secrets)
- Only commit `config.tmpl` template file
- Keep KeePassXC database secure and backed up
- Rotate tokens periodically in KeePassXC
- Use different tokens for different machines if needed

## Advanced Configuration

### Per-Repository Overrides

Git config has three levels:
1. System: `/etc/gitconfig`
2. Global: `~/.config/git/config` (this configuration)
3. Local: `.git/config` (per-repository)

Local config overrides global:

```bash
cd /path/to/repo
git config user.email "work@example.com"  # Only for this repo
```

### Conditional Includes

Add to `config.tmpl` for work/personal separation:

```git
[includeIf "gitdir:~/work/"]
  path = ~/.config/git/config-work

[includeIf "gitdir:~/personal/"]
  path = ~/.config/git/config-personal
```

### Custom Diff Drivers

For specific file types:

```git
[diff "json"]
  textconv = jq .

[diff "image"]
  textconv = exiftool
```

## Links

- [Git Documentation](https://git-scm.com/doc)
- [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
- [KeePassXC](https://keepassxc.org/)
- [Chezmoi Git Template](https://www.chezmoi.io/user-guide/password-managers/keepassxc/)
