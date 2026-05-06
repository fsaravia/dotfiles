# Dotfiles, 2026 edition

A small Apple Silicon macOS setup with:

- one small bootstrap command
- one package install command
- modern Zsh, Vim, Ghostty, and Git defaults
- an opt-in macOS defaults script
- a small Linux profile for owned SSH hosts

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

## Linux hosts

Owned Linux hosts can use the Linux profile:

```bash
./linux/install-packages
./linux/bootstrap
```

The Linux package installer targets Debian, Ubuntu, and other apt-based hosts; see [`linux/packages.md`](linux/packages.md). The Linux profile links the shared Vim and Git files, but uses [`linux/.zshrc`](linux/.zshrc) instead of the macOS shell config.

## What gets linked

- `~/.config/git/config`
- `~/.config/git/ignore`
- `~/.zshrc`
- `~/.vimrc`
- `~/.config/ghostty`

If a destination already exists as a real file or directory, `bootstrap` moves it into `~/.dotfiles-backups/<timestamp>/` before linking.

`linux/bootstrap` links:

- `~/.config/git/config`
- `~/.config/git/ignore`
- `~/.zshrc`
- `~/.vimrc`

Linux uses [`linux/git/config`](linux/git/config), which keeps shared Git defaults but leaves workstation-specific signing and `delta` configuration out of the base server profile.

## Packages

`Brewfile` includes the core tooling this setup expects:

- `bat`, `eza`, `fd`, `fzf`, `mise`, `ripgrep`, `zoxide`
- `git`, `gh`
- `git-delta`
- `shellcheck`
- `zsh-autosuggestions`, `zsh-syntax-highlighting`
- `ghostty`
- `font-jetbrains-mono-nerd-font`

## Validation

Check shell config and scripts with:

```bash
zsh -n .zshrc
zsh -n linux/.zshrc
bash -n bootstrap linux/bootstrap install-packages linux/install-packages cleanup-home macos-defaults.sh
shellcheck bootstrap linux/bootstrap install-packages linux/install-packages cleanup-home macos-defaults.sh
```

## Terminal upgrades

Git diff, show, and patch logs are rendered through `delta`. Use `z <directory hint>` to jump to frequent directories, and `bat <file>` when you want a nicer file read than `cat`.

Work-laptop Dart and Flutter paths stay supported in [`.zshrc`](.zshrc), but only when `~/.pub-cache/bin` or `~/Development/flutter/bin` exist.

`mise` is installed and activated for project-local tool versions. This repo does not pin global language runtimes; individual projects can use `mise.toml` or `.tool-versions`.

If Docker is installed, `install-packages` generates zsh completions into `~/.local/share/zsh/site-functions`.

## Git signing

Commits are signed by default. Keep machine-specific signing keys out of the repo by setting them in `~/.config/git/config.local`:

```bash
cp git/config.local.example ~/.config/git/config.local
git config --file ~/.config/git/config.local user.signingkey <your-gpg-key-fingerprint>
```
