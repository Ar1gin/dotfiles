# Duck's dotfiles
## Screenshots
2025-04-06 (468f08ad) | 2024-07-03 (ee72f101)
-|-
![Neovim+Foot](screenshots/preview_468f08ad.png) | ![Neovim+Wezterm](screenshots/preview_ee72f101.png)
## Available configurations
Crossed out are not used nor maintained

- Fish
- Fontconfig
- Foot term
- Jujutsu VCS
- ~Kitty~
- ~Neovide~
- Neovim
- ~Nushell~
- Starship
- Tmux
- ~Wezterm~
- ~Zellij~
- ~Zsh~
## Requirements

### General
- [GNU Make](https://www.gnu.org/software/make/) (initializes some auto-generated files)
	- [GNU Stow](https://www.gnu.org/software/stow/) (manages symlinks)

### Any shell
- [Starship](https://starship.rs/)
	- [Jujutsu](https://github.com/jj-vcs/jj)
	- Git
- [Zoxide](https://github.com/ajeetdsouza/zoxide)

### Any terminal emulator
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
- [Nerd Fonts](https://www.nerdfonts.com/) patch of `JetBrains Mono` preferred

### Neovim
- Version 0.11.0 (not tested on older versions)
- Git (required to initialize lazy)

### Neovim LSP servers
- `rust-analyzer` for `rust`
- `clangd` for `C`, `C++`
- `pylsp` for `python`
- `marksman` for `markdown`
- `taplo` for `toml`
- `zls` for `zig`
- `ts_ls` for `typescript`
- `gopls` for `go`
- `texlab` for `tex`

## Installation
Dotfiles are managed by `stow` via `make`. (All files/directores in `config/` are symlinked to `~/.config/`)

Apply dotfiles
```bash
make stow
```

Unapply dotfiles
```bash
make unstow
```

Reapply dotfiles
```bash
make restow
```

These commands are here mostly as a reminder, unless you want to use all of my dotfiles.
## License
I don't really care about licenses, you are free to copy/edit/share the dotfiles.
Some artwork included in the repository is not owned by me, look for `README.txt` files which contain ownership information.
