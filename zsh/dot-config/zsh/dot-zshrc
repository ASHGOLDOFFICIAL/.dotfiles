unsetopt autocd beep extendedglob

# Vi Mode
bindkey -v
zstyle :compinstall filename '/home/ashgoldofficial/.zshrc'
autoload -Uz compinit
compinit

# Aliases
alias -- diff='colordiff'
alias -- grep='grep --color=auto'
alias -- l='clear'
alias -- ls='ls --color=auto'
alias -- ll='ls -lah --color=auto'
alias -- python='python3'
alias -- svi='sudoedit --'
alias -- venv='source ./venv/bin/activate'

# History within the shell
HISTFILE=$XDG_STATE_HOME/zsh/history
HISTSIZE=10000
SAVEHIST=10000

# Prompt
setopt PROMPT_SUBST
export PROMPT='%F{green}%n%f %F{blue}%~%f %# '

# Setting default editor
export EDITOR=nvim
export SUDO_EDITOR=$EDITOR
export VISUAL=$EDITOR

export PATH=$HOME/.local/bin:$PATH

