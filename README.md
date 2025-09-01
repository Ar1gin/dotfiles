# Duck's dotfiles
## Screenshots
2025-04-06 (468f08ad) | 2024-07-03 (ee72f101)
-|-
![Neovim+Foot](screenshots/preview_468f08ad.png) | ![Neovim+Wezterm](screenshots/preview_ee72f101.png)
## Available configurations
- Fish
- Fontconfig
- Foot term
- Fuzzel
- Ghostty
- Neovim
- Niri
- Quickshell
- Starship
- Tmux
## Requirements

### General
- [GNU Make](https://www.gnu.org/software/make/) (initializes some auto-generated files)
	- [GNU Stow](https://www.gnu.org/software/stow/) (manages symlinks)

### Shell
- [Starship](https://starship.rs/)
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

### Niri
- [qt6ct](https://github.com/trialuser02/qt6ct) to style QT apps
- [Quickshell](https://quickshell.org/) as Bar
- [SWWW](https://github.com/LGFae/swww) as Wallpaper Engine
- [xwayland-satellite](https://github.com/Supreeeme/xwayland-satellite) to run X11 apps
- [Fuzzel](https://codeberg.org/dnkl/fuzzel) as Runner
- [Firefox](https://www.firefox.com/) as Browser
- [Ghostty](https://ghostty.org/) as Terminal Emulator

## Installation
Dotfiles are managed by `stow` via `make`. (All files/directores in `config/` are symlinked to `~/.config/`)

Apply dotfiles
```sh
make stow
```

Unapply dotfiles
```sh
make unstow
```

Reapply dotfiles
```sh
make restow
```

These commands are here mostly as a reminder, unless you want to use all of my dotfiles.
