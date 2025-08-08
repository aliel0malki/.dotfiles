# PS1='\n\e[34m$PWD\e[0m * '

# Aliases
alias v="nvim"
alias t="tmux"
alias q="exit"
alias c="clear"
alias mount='mount |column -t'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias ports='netstat -tulanp'
alias wget='wget -c'
alias path='echo -e ${PATH//:/\\n}'
alias mkdir='mkdir -pv'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -rf'
alias ls='ls -a --color=auto'
alias ln='ln -i'
alias du='du -ch'
alias emacs='emacs -nw'

# PATHS
export PATH=$PATH:/usr/local/go/bin
export BUN_INSTALL=$HOME/.bun
export PATH=$BUN_INSTALL/bin:$PATH
export PATH=$PATH:~/.zig/

alias tmux-sessionizer='~/tmux-sessionizer.sh'
bind -x '"\C-f": tmux-sessionizer'
