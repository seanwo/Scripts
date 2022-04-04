#!/bin/bash

# Cache Sudo

sudo echo

# Homebrew

echo Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $(uname -m) == 'arm64' ]]; then
    	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile    
    else
    	echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.bash_profile
    fi
    echo Homebrew installed.
fi
if [[ $(uname -m) == 'arm64' ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
else
	eval "$(/usr/local/bin/brew shellenv)"
fi
brew update
echo Homebrew updated.

read -p "Press enter to continue"

# Xcode Command Line Tools

echo Xcode CommandLineTools
if [[ $(xcode-select -p) != '/Library/Developer/CommandLineTools' ]]; then
	xcode-select --install
	echo Xcode CommandLineTools Installed.
else
	echo Xcode CommandLineTools already installed.
fi

read -p "Press enter to continue"

# mas-cli

echo mas-cli
if brew ls --versions mas > /dev/null; then
	echo mas-cli already installed.
else
	brew install mas
	echo mas-cli installed.
fi

# AppStore

declare -a mas_apps=(
"1474276998" #HP Smart
"1295203466" #Microsoft Remote Desktop
"409203825" #Numbers
"1480068668" #Messenger
"408981434" #iMovie
"409201541" #Pages
"1342896380" #Hex Fiend
"409183694" #Keynote
"937984704" #Amphetamine
"1186187538" #Ethernet Status
"405399194" #Kindle
)

echo AppStore Applications
for val in ${mas_apps[@]}; do
	if ! $HOMEBREW_PREFIX/bin/mas list | grep -q "$val"; then
		$HOMEBREW_PREFIX/bin/mas install $val
	fi
done
$HOMEBREW_PREFIX/bin/mas upgrade

read -p "Press enter to continue"

# Homebrew Taps

declare -a brew_taps=(
"homebrew/cask-drivers"
"homebrew/cask-versions"
"buo/cask-upgrade"
)

echo Homebrew Taps
for val in ${brew_taps[@]}; do
	brew tap $val
done

read -p "Press enter to continue"

# Homebrew Applications

declare -a brew_apps=(
"arp-scan"
"awscli"
"ethereum"
"gnupg"
"node"
"telnet"
"wget"
)

echo Homebrew Applications
for val in ${brew_apps[@]}; do
	if ! brew ls --versions $val > /dev/null; then
		brew install $val
	fi
done

if ! brew ls --versions jenv > /dev/null; then
	brew install jenv
	echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bash_profile   
	echo 'eval "$(jenv init -)"' >> ~/.bash_profile
	export PATH="$HOME/.jenv/bin:$PATH"
	eval "$(jenv init -)"
fi

read -p "Press enter to continue"

# Homebrew Casks

declare -a cask_apps=(
"android-file-transfer"
"app-cleaner"
"arq5"
"balenaetcher"
"bbedit"
"betterzip"
"calibre"
"disk-inventory-x"
"dropbox"
"firefox"
"gfxcardstatus"
"google-chrome"
"google-drive"
"hp-easy-start"
"intellij-idea-ce"
"litecoin"
"logitech-options"
"menumeters"
"mycrypto"
"paintbrush"
"plex"
"quicken"
"rectangle"
"shotcut"
"signal"
"skype"
"slack"
"spotify"
"steam"
"teamviewer"
"temurin8"
"timemachineeditor"
"tunnelblick"
"visual-studio-code"
"vlc"
"zoom"
)

echo Homebrew Casks
for val in ${cask_apps[@]}; do
	if ! brew ls --versions --cask $val > /dev/null; then
		brew install --cask $val
	fi
done

brew upgrade

read -p "Press enter to continue"