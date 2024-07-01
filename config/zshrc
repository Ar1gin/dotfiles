HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep
bindkey -e

# The following lines were added by compinstall
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Cool stuff
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# ZSH plugins
source ~/.zshplugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=white"
source ~/.zshplugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Opts
setopt HIST_IGNORE_SPACE

# Aliases
alias pwn="ssh"
alias yoink="scp"
alias zl="zellij"
alias zla="zellij attach"
alias zll="zellij list-sessions"
alias zlc="zellij --layout=compact"
alias ls="exa -lGb --no-permissions --no-user --no-time"
alias ll="exa -l"
alias cat="bat"
alias lg="lazygit"
alias nv="nvim"
alias df="duf"
alias duai="dua i"
alias tw="taskwarrior-tui"

export EDITOR=nvim
export RUSTC_WRAPPER=sccache
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
