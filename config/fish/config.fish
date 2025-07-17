set -gx EDITOR nvim
set -gx MANPAGER nvim +Man!

set -U fish_greeting
set history_ignore rm

function ll
    command exa -l $argv
end
function cat
    command bat $argv
end

function fish_should_add_to_history
    for cmd in $history_ignore
        string match -qr "^$cmd" -- $argv; and return 1
    end
    return 0
end

if status is-interactive
    starship init fish | source
    zoxide init fish | source
end
