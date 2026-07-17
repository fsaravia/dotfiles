# Agent Notes

This is Federico's personal dotfiles repo for Apple Silicon macOS and owned Linux hosts. Keep changes small, explicit, and easy to reason about during a fresh-machine setup.

## Repo Shape

- `.zprofile` initializes Homebrew for macOS login shells; `.zshrc` is the main interactive shell config.
- `git/config` is linked to `~/.config/git/config`, Git's tracked XDG config path.
- `git/ignore` is linked to `~/.config/git/ignore`, Git's default global ignore path.
- `~/.gitconfig` remains a machine-local mode-`0600` regular file reserved for `user.signingkey`; bootstraps create it empty when absent and never symlink it.
- `ghostty/` is linked to `~/.config/ghostty`.
- `Brewfile` is the source of truth for Homebrew packages expected by the shell.
- `bootstrap` supports Apple Silicon macOS, rejects root and sudo-wrapped execution, creates symlinks, and preserves replaced paths in a private `~/.dotfiles-backups/<timestamp>/` tree.
- `install-packages` supports Apple Silicon macOS, installs Homebrew from a fully downloaded installer when needed, runs `brew bundle --jobs auto`, and requires valid Docker zsh completions when Docker Desktop is installed.
- `linux/` contains the Linux profile for owned Debian/Ubuntu-style hosts.
- `linux/bootstrap` rejects sudo-wrapped execution, creates Linux symlinks, preserves replaced paths in a private backup tree, and uses the current user's `chsh` directly when the login shell must change.
- `linux/install-packages` supports Debian 13 and Ubuntu 24.04 or 26.04, requires its full apt package set, creates canonical local `bat`/`fd` links, asserts the shell plugin paths, and requires valid Docker zsh completions when Docker is present.
- `macos-defaults.sh` checks or applies the opt-in macOS 26 preferences.
- `check` runs syntax, formatting, Git, Vim, whitespace, and macOS Ghostty validation.

## Editing Principles

- Prefer boring, readable shell over cleverness.
- Use Bash for repo scripts and keep `set -euo pipefail`.
- Keep scripts idempotent where practical.
- Keep `git/ignore` limited to universal local noise such as OS metadata, temporary editor files, tool caches, and local-only tool overrides. Do not add shareable project files like `mise.toml`.
- Do not introduce a plugin manager for zsh unless explicitly requested.
- Do not guard commands or files installed by `Brewfile` in shell config. Missing expected tools should fail visibly so the terminal points at what needs installing.
- Keep `/opt/homebrew/bin/brew shellenv` in `.zprofile` as the sole Homebrew initialization; it is intentionally unguarded.
- The Linux zsh config may assume packages installed by `linux/install-packages`; keep that profile direct unless a dependency is truly optional.
- It is fine to guard truly optional integrations, such as Docker completions or work-laptop Dart/Flutter paths.
- Keep machine-specific or secret values out of the repo. `~/.gitconfig` is a mode-`0600` regular file reserved for the machine's `user.signingkey`; do not add signing-key identifiers to the tracked configs.
- `.zshrc` and `linux/.zshrc` intentionally duplicate common shell behavior. When editing one, check whether the same practical behavior should carry to the other, while preserving OS-specific differences.
- `git/config` and `linux/git/config` intentionally differ around macOS-only `delta` integration. Keep shared aliases, push behavior, conflict handling, and mandatory commit signing aligned.

## Package Policy

- `Brewfile` is the complete Apple Silicon macOS package set. The shell expects those commands and plugin files to exist after `install-packages` succeeds.
- `linux/install-packages` has one required package set for Debian 13 and Ubuntu 24.04 or 26.04. Missing apt packages are fatal; do not restore partial installation behavior.
- Linux uses the distribution commands at `/usr/bin/batcat` and `/usr/bin/fdfind` through canonical links in `~/.local/bin`.
- Docker is optional. When Docker Desktop or `/usr/bin/docker` is present, completion generation is required to succeed and must replace `_docker` atomically.

## Validation

Run the repository checks after edits:

- All shell files: `./check`
- Brewfile changes: `brew bundle check --file Brewfile` when Homebrew is available and checking the local machine is useful.

Avoid running `bootstrap`, `linux/bootstrap`, `install-packages`, `linux/install-packages`, or `macos-defaults.sh` without the user's explicit intent. They mutate the user's home directory, install software, or change system preferences.

## Style Notes

- Keep comments short and practical.
- Preserve the existing direct symlink model.
- Prefer `/opt/homebrew` paths for Homebrew-specific assumptions.
- Keep Linux package assumptions apt-based unless Federico asks to support another distro family.
- Update `README.md` when setup behavior, linked files, or expected packages change.
