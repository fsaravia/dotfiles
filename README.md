# Dotfiles, 2026 edition

A small Apple Silicon macOS setup with:

- one small bootstrap command
- one package install command
- modern Zsh, Ghostty, and Git defaults
- an opt-in macOS defaults script

## Quick start

Link the dotfiles:

```bash
./bootstrap
```

Install packages:

```bash
./install-packages
```

Apply macOS defaults:

```bash
./macos-defaults.sh
```

## What gets linked

- `~/.gitconfig`
- `~/.gitignore`
- `~/.zshrc`
- `~/.config/ghostty`

If a destination already exists as a real file or directory, `bootstrap` moves it into `~/.dotfiles-backups/<timestamp>/` before linking.

## Packages

`Brewfile` includes the core tooling this setup expects:

- `eza`, `fd`, `fzf`, `ripgrep`
- `git`, `gh`
- `zsh-autosuggestions`, `zsh-syntax-highlighting`
- `ghostty`
- `font-jetbrains-mono-nerd-font`

Flutter stays supported in [.zshrc](/Users/fsaravia/Development/dotfiles/.zshrc:18), but only if the SDK exists at `~/Development/flutter/bin`.

## Git signing

Commits are signed by default. Keep machine-specific signing keys out of the repo by setting them in `~/.gitconfig.local`:

```bash
cp .gitconfig.local.example ~/.gitconfig.local
git config --file ~/.gitconfig.local user.signingkey <your-gpg-key-fingerprint>
```
