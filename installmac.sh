#!/bin/bash

# Homebrew

echo Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo Homebrew installed.
else
    brew update
    echo Homebrew updated.
fi

if [[ $(uname -m) == 'arm64' ]]; then
	brewbin="/opt/homebrew"
else
	brewbin="/usr/local/bin"
fi

# Xcode Command Line Tools

echo Xcode CommandLineTools
if [[ $(xcode-select -p) != '/Library/Developer/CommandLineTools' ]]; then
	xcode-select --install
	echo Xcode CommandLineTools Installed.
else
	echo Xcode CommandLineTools already installed.
fi

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
	if ! $brewbin/mas list | grep -q "$val"; then
		$brewbin/mas install $val
	fi
done
$brewbin/mas upgrade

# Homebrew Taps

declare -a brew_taps=(
"homebrew/cask-drivers"
"homebrew/cask-versions"
"buo/cask-upgrade"
)

echo Homebrew Taps
for val in ${brew_taps[@]}; do
	$brewbin/brew tap $val
done

# Homebrew Applications

declare -a brew_apps=(
"arp-scan"
"awscli"
"ethereum"
"gnupg"
"jenv"
"node"
"telnet"
"wget"
)

echo Homebrew Applications
for val in ${brew_apps[@]}; do
	if ! brew ls --versions $val > /dev/null; then
		$brewbin/brew install $val
	fi
done

# Homebrew Casks

declare -a cask_apps=(
"android-file-transfer"
"android-messages"
"app-cleaner"
"arq5"
"balenaetcher"
"bbedit"
"betterzip"
"calibre"
"disk-inventory-x"
"dropbox"
"filezilla"
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
"shotcut"
"signal"
"skype"
"slack"
"spectacle"
"spotify"
"steam"
"teamviewer"
"temurin8"
"timemachineeditor"
"tunnelblick"
"visual-studio-code"
"vlc"
# "vmware-fusion-tech-preview"
"zoom"
)

echo Homebrew Casks
for val in ${cask_apps[@]}; do
	if ! brew ls --versions --cask $val > /dev/null; then
		$brewbin/brew install $val
	fi
done

$brewbin/brew upgrade