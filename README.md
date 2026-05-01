# Dotfiles, 2026 edition

A small macOS-first setup with:

- explicit symlink targets instead of wildcard magic
- optional Homebrew bootstrapping and package installs
- modern Zsh, tmux, Ghostty, and Git defaults
- an opt-in macOS defaults script

## Quick start

Link the dotfiles:

```bash
./bootstrap
```

Link dotfiles, install packages, and apply macOS defaults:

```bash
./bootstrap --all
```

Show available options:

```bash
./bootstrap --help
```

## What gets linked

- `~/.gemrc`
- `~/.gitconfig`
- `~/.gitignore`
- `~/.tmux.conf`
- `~/.zshrc`
- `~/.config/ghostty`

If a destination already exists as a real file or directory, `bootstrap` moves it into `~/.dotfiles-backups/<timestamp>/` before linking.

## Packages

`Brewfile` includes the core tooling this setup expects:

- `eza`, `fd`, `ripgrep`, `bat`
- `git`, `gh`, `tmux`
- `zsh-autosuggestions`, `zsh-syntax-highlighting`
- `ghostty`
- `font-jetbrains-mono-nerd-font`

## macOS defaults

Run the script directly:

```bash
./macos-defaults.sh
```
