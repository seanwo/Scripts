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
	echo Xcode CommandLineTools installed.
else
	echo Xcode CommandLineTools already installed.
fi

read -p "Press enter to continue"

# Rosetta

if [[ $(uname -m) == 'arm64' ]]; then
	echo Rosetta
	if /usr/bin/pgrep oahd >/dev/null 2>&1; then
		echo Rosetta already installed.
	else
		softwareupdate --install-rosetta --agree-to-license
		echo Rosetta installed.
	fi
	read -p "Press enter to continue"
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
"1480068668" #Messenger
"408981434" #iMovie
"937984704" #Amphetamine
"1186187538" #Ethernet Status
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
"buo/cask-upgrade"
"orangedrangon/apps"
)

echo Homebrew Taps
for val in ${brew_taps[@]}; do
	brew tap $val
done

read -p "Press enter to continue"

# Homebrew Applications

declare -a brew_apps=(
"wget"
)

echo Homebrew Applications
for val in ${brew_apps[@]}; do
	if ! brew ls --versions $val > /dev/null; then
		brew install $val
	fi
done

# Homebrew Casks

declare -a cask_apps=(
"adobe-acrobat-reader"
"android-file-transfer"
"android-messages-orangedrangon"
"app-cleaner"
"bbedit"
"discord"
"dropbox"
"firefox"
"google-chrome"
"google-drive"
"menumeters"
"plex"
"rectangle"
"signal"
"skype"
"spotify"
"steam"
"timemachineeditor"
"yubico-authenticator"
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
