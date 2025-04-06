# Duck's dotfiles
## Screenshots
2025-04-06 (468f08ad) | 2024-07-03 (ee72f101)
-|-
![Neovim+Foot](screenshots/preview_468f08ad.png) | ![Neovim+Wezterm](screenshots/preview_ee72f101.png)
## Available configurations
- Fish
- Fontconfig
- Foot term
- Jujutsu VCS
- Kitty
- Neovide
- Neovim
- Nushell
- Starship
- Tmux
- Wezterm
- Zellij
- Zsh
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
