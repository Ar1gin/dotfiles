set -gx EDITOR nvim
set -gx MANPAGER nvim +Man!

set -U fish_greeting

function ll
    command exa -l $argv
end
function cat
    command bat $argv
end

if status is-interactive
    starship init fish | source
    zoxide init fish | source
end
