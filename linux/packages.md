# Linux Packages

Run the apt-based installer on Debian, Ubuntu, and similar hosts:

```bash
./linux/install-packages
```

It installs:

- `bat`
- `eza`
- `fd-find`
- `fzf`
- `gh`
- `git`
- `git-delta`
- `mise`
- `ripgrep`
- `shellcheck`
- `vim`
- `zoxide`
- `zsh`
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`

If a package name is unavailable in the host's apt repositories, the installer prints a warning and installs the packages it can find.

The zsh config assumes Debian/Ubuntu package paths for fzf and zsh plugins under `/usr/share`.
