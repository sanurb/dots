# File system
alias ls='eza -lh --group-directories-first --icons'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'batcat --style=numbers --color=always {}'"
alias fd='fdfind'
alias cd='z'
alias rmf="rm -rf"

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....="cd ../../../../"

# Tools
alias n='nvim'
alias g='git'
alias d='docker'
alias bat='batcat'
alias lzg='lazygit'
alias lzd='lazydocker'

# Git
# see /config/git

# Editor
alias e='nvim $(files)'
alias emd='emacs --daemon &'
alias emc="emacsclient -c -a 'emacs'"
alias emt='emacs --no-window-system'
alias vi="nvim"
alias me='"$EDITOR" README.md'

# Compression
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"
