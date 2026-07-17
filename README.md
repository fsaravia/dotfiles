# Dotfiles

A small Apple Silicon macOS setup with:

- one small bootstrap command
- one package install command
- modern Zsh, Vim, Ghostty, and Git defaults
- an opt-in macOS defaults script
- a small Linux profile for owned SSH hosts

## Quick start

Install packages:

```bash
./install-packages
```

Link the dotfiles:

```bash
./bootstrap
```

Run both commands directly as a regular user, without `sudo`. The setup supports only Apple Silicon macOS 26 and validates the platform and execution user before changing any files.

Optionally check or apply the macOS 26 defaults:

```bash
./macos-defaults.sh --check
./macos-defaults.sh
```

## Linux hosts

Owned Linux hosts can use the Linux profile:

```bash
./linux/install-packages
./linux/bootstrap
```

The Linux package installer supports Debian 13 and Ubuntu 24.04 or 26.04. Run it as the target user; it validates the distribution, authenticates with `sudo`, and requires the complete package set before installing anything. It links `~/.local/bin/bat` and `~/.local/bin/fd` to the canonical Debian-family commands at `/usr/bin/batcat` and `/usr/bin/fdfind`. The Linux profile links the shared Vim and Git ignore files, but uses [`linux/.zshrc`](linux/.zshrc) and [`linux/git/config`](linux/git/config).

Run `linux/bootstrap` directly, never through `sudo`. Genuine root sessions are supported. If the current user's login shell is not zsh, the bootstrap requires an interactive terminal and invokes the user's `chsh` directly; failure to change the shell stops the setup.

## What gets linked

- `~/.config/git/config`
- `~/.config/git/ignore`
- `~/.zprofile`
- `~/.zshrc`
- `~/.vimrc`
- `~/.config/ghostty`

The macOS `.zprofile` initializes Homebrew from `/opt/homebrew` for login shells. Homebrew and the shell tools managed by `Brewfile` are required; the startup files do not hide missing installations.

If a destination already exists as a real file or directory, or as a wrong or dangling symlink, `bootstrap` moves it into a private `~/.dotfiles-backups/<timestamp>/` tree while preserving its path below `HOME`. A symlink already pointing to the expected tracked file is left untouched. Both bootstraps validate their arguments, platform, execution context, sources, destinations, backup root, machine-local Git config, and login-shell requirements before creating links.

Both bootstraps also ensure that `~/.gitconfig` is a mode-`0600` regular file, never a symlink. This private file is reserved for `user.signingkey`; the tracked Git defaults remain linked at `~/.config/git/config`. A missing `~/.gitconfig` is created empty so setup never guesses a signing identity.

`linux/bootstrap` links:

- `~/.config/git/config`
- `~/.config/git/ignore`
- `~/.zshrc`
- `~/.vimrc`

Linux uses [`linux/git/config`](linux/git/config), which keeps the shared Git defaults and mandatory commit signing but omits the macOS-only `delta` integration.

The Linux zsh config assumes Debian/Ubuntu package paths for fzf and zsh plugins under `/usr/share`.

## Packages

The macOS package installer supports Apple Silicon macOS and must be run without `sudo`. `Brewfile` includes the core tooling this setup expects:

- `bat`, `eza`, `fd`, `fzf`, `mise`, `ripgrep`, `zoxide`
- `git`, `gh`, `gnupg`
- `git-delta`
- `shellcheck`, `shfmt`
- `zsh-autosuggestions`, `zsh-syntax-highlighting`
- `ghostty`
- `font-jetbrains-mono-nerd-font`

The Linux package set is intentionally explicit:

- `bat`, `eza`, `fd-find`, `fzf`, `ripgrep`, `zoxide`
- `git`, `gh`, `gnupg`, `jq`, `less`, `vim`
- `shellcheck`, `shfmt`
- `zsh`, `zsh-autosuggestions`, `zsh-syntax-highlighting`

Linux leaves `git-delta` and `mise` out of the server profile.

## Validation

Run the repository's non-mutating checks with:

```bash
./check
```

This checks Bash and zsh syntax and formatting, runs ShellCheck, parses both Git configs, loads the Vim config, checks changed-line whitespace, and validates the Ghostty config on macOS.

## Terminal upgrades

On macOS, Git diff, show, and patch logs are rendered through `delta`. Use `z <directory hint>` to jump to frequent directories, and `bat <file>` when you want a nicer file read than `cat`.

Work-laptop Dart and Flutter paths stay supported in [`.zshrc`](.zshrc), but only when `~/.pub-cache/bin` or `~/Development/flutter/bin` exist.

`mise` is installed and activated on macOS for project-local tool versions. This repo does not pin global language runtimes; individual projects can use `mise.toml` or `.tool-versions`. Local-only mise overrides such as `mise.local.toml` and `.mise.local.toml` are ignored globally.

When Docker Desktop exists at `/Applications/Docker.app`, the macOS installer requires its canonical `/usr/local/bin/docker` command and atomically generates zsh completions into `~/.local/share/zsh/site-functions`. The Linux installer does the same when `/usr/bin/docker` is installed. Completion failures stop either installer instead of leaving a partial file.

## Git signing

Both Git profiles require GPG-signed commits. After bootstrap, set the full fingerprint in the private machine-local Git config, then make sure the local GnuPG keyring contains that secret key:

```bash
git config set --global user.signingkey <full-gpg-fingerprint>
gpg --list-secret-keys <full-gpg-fingerprint>
```

`~/.gitconfig` may contain only `user.signingkey`; all shareable Git behavior belongs in the tracked platform config. Both zsh profiles set `GPG_TTY` for terminal-based passphrase prompts. Missing GnuPG or signing-key configuration is intentionally fatal: Git does not fall back to unsigned commits.

Both Git configs automatically establish the upstream on the first default push. Use `git sw <branch>` for branch switching and `git f` for fetching; pruning is already enabled globally.
