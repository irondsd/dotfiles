export PATH
export ZSH="/Users/irondsd/.oh-my-zsh"
export PATH=/.npm-global/bin:$PATH
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/Users/irondsd/.kit/bin"
export VOLTA_HOME="$HOME/.volta"
export PATH=/opt/homebrew/bin:$PATH
export PATH="$VOLTA_HOME/bin:$PATH"
PATH=~/.console-ninja/.bin:$PATH

# Activate syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -А ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Activate autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh


#hidden files
alias showhidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidehidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias hide="chflags hidden"
alias unhide="chflags nohidden"

#ip
alias lip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias myip="curl http://ipecho.net/plain; echo"  

#navigation
alias ..="cd .."
alias ...="cd ../.."

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
alias gcd="git checkout dev"
alias gcs="git checkout stage-prod"
alias gcm="git checkout main"
alias vim="nvim"
alias vi="nvim"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"
alias jj="pbpaste | jsonpp | pbcopy"
alias ls='exa'
alias la='exa -la'
alias git-branch-cleanup="git branch | grep -vE 'master|main|dev' | xargs git branch -D"
alias dir-sizes="du -hs * | sort -hr"
alias dir-size="du -sh ."
alias disable-apple-music="launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist"

eval "$(starship init zsh)"
