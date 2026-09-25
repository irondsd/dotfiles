export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export GPG_TTY="$TTY"

# zoxide
eval "$(zoxide init zsh)"

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# starship
eval "$(starship init zsh)"

# Completion system, including completions installed by zsh-abbr.
fpath=("${HOMEBREW_PREFIX:-$(brew --prefix)}/share/zsh-abbr" $fpath)
autoload -Uz compinit
compinit

# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Activate autosuggestions
source "${HOMEBREW_PREFIX:-$(brew --prefix)}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Edit the current command line like a text editor: Shift+Arrow selection,
# Cmd-based editing, and mouse-aware selection support.
ZSH_EDIT_SELECT_PLUGIN="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins/zsh-edit-select/zsh-edit-select.plugin.zsh"
if [[ -r "$ZSH_EDIT_SELECT_PLUGIN" ]]; then
  source "$ZSH_EDIT_SELECT_PLUGIN"
fi
unset ZSH_EDIT_SELECT_PLUGIN

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

#hidden files
alias showhidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidehidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias hide="chflags hidden"
alias unhide="chflags nohidden"

#ip
alias lip="ipconfig getifaddr en0"
alias ip="curl -fsS https://api.ipify.org; echo"

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
alias python="python3"
alias vi="nvim"
alias jj="pbpaste | jsonpp | pbcopy"
alias ls='eza'
alias la='eza -la'
alias dir-sizes="du -hs *(D) | sort -hr"
alias dir-size="du -sh ."
alias gbc="git branch --merged dev | grep -Ev \"(^\*|main|stage|dev|develop)\" | xargs git branch -d"

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"


# Bun completions
[[ -s "${BUN_INSTALL:-$HOME/.bun}/_bun" ]] && source "${BUN_INSTALL:-$HOME/.bun}/_bun"

# Expand short abbreviations into readable commands before execution.
source "${HOMEBREW_PREFIX:-$(brew --prefix)}/share/zsh-abbr/zsh-abbr.zsh"

# Auto-close matching quotes, brackets, and braces. This loads after zsh-abbr
# so its Space widget can delegate to abbreviation expansion.
source "${HOMEBREW_PREFIX:-$(brew --prefix)}/share/zsh-autopair/autopair.zsh"

# Syntax highlighting must be loaded after all other ZLE plugins and widgets.
source "${HOMEBREW_PREFIX:-$(brew --prefix)}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
