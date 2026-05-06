# Agent Notes

This is Federico's personal dotfiles repo for Apple Silicon macOS and owned Linux hosts. Keep changes small, explicit, and easy to reason about during a fresh-machine setup.

## Repo Shape

- `.zshrc` is the main interactive shell config.
- `git/config` is linked to `~/.config/git/config`, Git's default XDG config path.
- `git/ignore` is linked to `~/.config/git/ignore`, Git's default global ignore path.
- `ghostty/` is linked to `~/.config/ghostty`.
- `Brewfile` is the source of truth for Homebrew packages expected by the shell.
- `bootstrap` creates symlinks and backs up existing real files into `~/.dotfiles-backups/<timestamp>/`.
- `install-packages` installs Homebrew if needed, runs `brew bundle`, and generates optional Docker zsh completions when Docker is present.
- `linux/` contains the Linux profile for owned Debian/Ubuntu-style hosts.
- `linux/install-packages` installs apt packages and generates optional Docker zsh completions when Docker is present.
- `linux/bootstrap` creates Linux symlinks, backs up existing real files into `~/.dotfiles-backups/<timestamp>/`, and sets zsh as the login shell when root or passwordless sudo is available.
- `macos-defaults.sh` applies opt-in macOS preferences.

## Editing Principles

- Prefer boring, readable shell over cleverness.
- Use Bash for repo scripts and keep `set -euo pipefail`.
- Keep scripts idempotent where practical.
- Keep `git/ignore` limited to universal local noise such as OS metadata, temporary editor files, and tool caches. Do not add project files like language configs.
- Do not introduce a plugin manager for zsh unless explicitly requested.
- Do not guard commands or files installed by `Brewfile` in shell config. Missing expected tools should fail visibly so the terminal points at what needs installing.
- The Linux zsh config may assume packages installed by `linux/install-packages`; keep that profile direct unless a dependency is truly optional.
- It is fine to guard truly optional integrations, such as Docker completions or work-laptop Dart/Flutter paths.
- Keep machine-specific or secret values out of the repo. Use `~/.config/git/config.local` for local Git signing keys.
- `.zshrc` and `linux/.zshrc` intentionally duplicate common shell behavior. When editing one, check whether the same practical behavior should carry to the other, while preserving OS-specific differences.
- `git/config` and `linux/git/config` intentionally differ around workstation-specific settings such as signing and `delta`. When editing shared aliases or general Git behavior, consider updating both.

## Validation

Run the lightest relevant checks after edits:

- `.zshrc`: `zsh -n .zshrc`
- `linux/.zshrc`: `zsh -n linux/.zshrc`
- Bash scripts: `bash -n bootstrap linux/bootstrap install-packages linux/install-packages macos-defaults.sh`
- Brewfile changes: `brew bundle check --file Brewfile` when Homebrew is available and checking the local machine is useful.

Avoid running `bootstrap`, `linux/bootstrap`, `install-packages`, `linux/install-packages`, or `macos-defaults.sh` without the user's explicit intent. They mutate the user's home directory, install software, or change system preferences.

## Style Notes

- Keep comments short and practical.
- Preserve the existing direct symlink model.
- Prefer `/opt/homebrew` paths for Homebrew-specific assumptions.
- Keep Linux package assumptions apt-based unless Federico asks to support another distro family.
- Update `README.md` when setup behavior, linked files, or expected packages change.
