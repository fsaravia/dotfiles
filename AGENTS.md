# Agent Notes

This is Federico's personal Apple Silicon macOS dotfiles repo. Keep changes small, explicit, and easy to reason about during a fresh-machine setup.

## Repo Shape

- `.zshrc` is the main interactive shell config.
- `git/config` is linked to `~/.config/git/config`, Git's default XDG config path.
- `git/ignore` is linked to `~/.config/git/ignore`, Git's default global ignore path.
- `ghostty/` is linked to `~/.config/ghostty`.
- `Brewfile` is the source of truth for Homebrew packages expected by the shell.
- `bootstrap` creates symlinks and backs up existing real files into `~/.dotfiles-backups/<timestamp>/`.
- `install-packages` installs Homebrew if needed, runs `brew bundle`, and generates optional Docker zsh completions when Docker is present.
- `macos-defaults.sh` applies opt-in macOS preferences.

## Editing Principles

- Prefer boring, readable shell over cleverness.
- Use Bash for repo scripts and keep `set -euo pipefail`.
- Keep scripts idempotent where practical.
- Keep `git/ignore` limited to universal local noise such as OS metadata, temporary editor files, and tool caches. Do not add project files like language configs.
- Do not introduce a plugin manager for zsh unless explicitly requested.
- Do not hide missing required shell dependencies. Expected Brew-installed zsh plugins should fail loudly so the terminal points at what needs installing.
- It is fine to guard truly optional integrations, such as Docker completions or a locally installed Flutter SDK.
- Keep machine-specific or secret values out of the repo. Use `~/.config/git/config.local` for local Git signing keys.

## Validation

Run the lightest relevant checks after edits:

- `.zshrc`: `zsh -n .zshrc`
- Bash scripts: `bash -n bootstrap install-packages macos-defaults.sh`
- Brewfile changes: `brew bundle check --file Brewfile` when Homebrew is available and checking the local machine is useful.

Avoid running `bootstrap`, `install-packages`, or `macos-defaults.sh` without the user's explicit intent. They mutate the user's home directory, install software, or change system preferences.

## Style Notes

- Keep comments short and practical.
- Preserve the existing direct symlink model.
- Prefer `/opt/homebrew` paths for Homebrew-specific assumptions.
- Update `README.md` when setup behavior, linked files, or expected packages change.
