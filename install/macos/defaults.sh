# https://github.com/linhe0x0/defaults-write

# Set dock hide and unhide instantly
defaults write com.apple.dock autohide-delay -float 0
defaults delete com.apple.dock autohide-delay
defaults write com.apple.dock autohide-time-modifier -int 0
defaults write com.apple.dock expose-animation-duration -float 0
killall Dock

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Define where to save screenshots
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"

# Show all filename extensions.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable terminal prompt
touch ~/.hushlogin
