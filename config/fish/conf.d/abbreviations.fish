# General
abbr -a nv nvim
abbr -a lg lazygit
abbr -a tx tmux
abbr -a pc pacman
abbr -a cl clear
function fastparentcd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr -a dotdot -r "^\.\.+\$" -f fastparentcd

# Git
abbr -a ga git add
abbr -a gbc git rebase --continue
abbr -a gb git rebase
abbr -a gca git commit --amend
abbr -a gc git commit
abbr -a gd git diff
abbr -a gds git diff --staged
abbr -a gea git remote add
abbr -a ge git remote
abbr -a ger git remote remove
abbr -a ges git remote show -n
abbr -a gf git fetch
abbr -a gg git push
abbr -a g git
abbr -a gp git pull
abbr -a gr git reset
abbr -a gri git rebase -i
abbr -a gs git status
abbr -a gss git status -s
abbr -a gt git restore
abbr -a gts git restore -S
abbr -a gw git switch

# Zig
abbr -a zbf zig build -OReleaseFast
abbr -a zbrf zig build run -OReleaseFast
abbr -a zbr zig build run
abbr -a zbt zig build test
abbr -a zb zig build
abbr -a zrf zig run -OReleaseFast
abbr -a zr zig run
abbr -a zt zig test
abbr -a zx zig build-exe
