# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Optimize plugin loading with deferred loading
plug "zsh-users/zsh-autosuggestions" 
plug "zap-zsh/supercharge" 
plug "wintermi/zsh-starship" 
plug "zsh-users/zsh-syntax-highlighting" 
plug "Aloxaf/fzf-tab" 
plug "wintermi/zsh-lsd" 
export VI_MODE_ESC_INSERT="jk" && plug "zap-zsh/vim" 

# Load and initialize completion system with caching
autoload -Uz compinit
compinit -C  # Avoid recomputation of completion cache
zstyle ':completion:*' rehash true  # Enable rehashing

# Aliases
alias vi=nvim
alias .=vi
alias v="vi"
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
alias ln='ln -i'
alias du='du -ch'

# Add Go and Bun paths
export PATH=$PATH:/usr/local/go/bin
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fnm setup (if installed)
FNM_PATH="/home/alewa/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/alewa/.local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"
fi

# Custom tmux function (remove if unused)
tmux () {
    TMUX="command tmux ${@}"
    SHELL=/bin/zsh script -qO /dev/null -c "eval $TMUX";
}

# Bun completions
[ -s "/home/alewa/.bun/_bun" ] && source "/home/alewa/.bun/_bun"

# Rehash to refresh the shell's knowledge of executables
rehash

# Optimize completion system loading
autoload -Uz compinit
compinit -C  # Use -C to skip recompiling cache every session