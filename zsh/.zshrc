export PATH
export ZSH="/Users/irondsd/.oh-my-zsh"
export PATH=/.npm-global/bin:$PATH
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/Users/irondsd/.kit/bin"
export PATH=/opt/homebrew/bin:$PATH
export GPG_TTY=$(tty)
PATH=~/.console-ninja/.bin:$PATH

# zoxide
eval "$(zoxide init zsh)"

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# starship
eval "$(starship init zsh)"

# Activate syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -А ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Activate autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# keybindings
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# fzf tab
eval "$(fzf --zsh)"
autoload -U compinit; compinit
source ~/bin/fzf-tab/fzf-tab.plugin.zsh

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'

#hidden files
alias showhidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidehidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias hide="chflags hidden"
alias unhide="chflags nohidden"

#ip
alias lip="ipconfig getifaddr en0"
alias ip="curl http://ipecho.net/plain; echo"  

setopt auto_cd

#macos
alias f='open -a Finder ./'
cdff () { cd "`ff $@`"; }
ff () { osascript -e 'tell application "Finder"'\
 -e "if (${1-1} <= (count Finder windows)) then"\
 -e "get POSIX path of (target of window ${1-1} as alias)"\
 -e 'else' -e 'get POSIX path of (desktop as alias)'\
 -e 'end if' -e 'end tell'; };\

#rest
zipf () { zip -r "$1".zip "$1" ; }                  # zipf:         Zip a folder
zipp () { zip -er "$1".zip "$1" ; }                 # zipp:         Zip a folder with password
killport () { npx kill-port "$1" ; }                # kill <port>  kills all the process of a port
function take {
    mkdir -p $1
    cd $1
}
alias hosts="sudo open -a sublime\ text /etc/hosts" 
alias edit='subl'
alias zshrc='subl ~/.zshrc'
alias update="source ~/.zshrc"
alias pg="ping google.com -c 20" 
alias gcb="git checkout -b"
alias gco="git checkout"
alias gcd="git checkout dev"
alias gcdd="git checkout develop"
alias gcs="git checkout stage"
alias gcm="git checkout main"
alias vim="nvim"
alias vi="nvim"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"
alias jj="pbpaste | jsonpp | pbcopy"
alias ls='eza'
alias la='eza -la'
alias git-branch-cleanup="git branch | grep -vE 'master|main|dev|stage|develop' | xargs git branch -D"
alias dir-sizes="du -hs * | sort -hr"
alias dir-size="du -sh ."
alias disable-apple-music="launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist"
alias gbc="git branch --merged dev | grep -Ev \"(^\*|master|main|dev|stage-prod)\" | xargs git branch -d"
