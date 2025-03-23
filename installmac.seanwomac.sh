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
"1295203466" #Microsoft Remote Desktop
"409203825" #Numbers
"1480068668" #Messenger
"408981434" #iMovie
"409201541" #Pages
"1342896380" #Hex Fiend
"409183694" #Keynote
"937984704" #Amphetamine
"1186187538" #Ethernet Status
"302584613" #Kindle
"1475387142" #Tailscale
"1168254295" #AmorphousDiskMark
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
"arp-scan"
"awscli"
"dosbox-x"
"f3"
"gnupg"
"iperf3"
"jenv"
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
"app-cleaner"
"applepi-baker"
"balenaetcher"
"bartender"
"bbedit"
"betterzip"
"calibre"
"chatgpt"
"crossover"
"disk-inventory-x"
"dropbox"
"eloston-chromium"
"firefox"
"geekbench"
"google-chrome"
"google-drive"
"intellij-idea-ce"
"keybase"
"localsend"
"macfuse"
"menumeters"
"obs"
"openmtp"
"openvpn-connect"
"paintbrush"
"plex"
"quicken"
"raspberry-pi-imager"
"rectangle"
"sensiblesidebuttons"
"shotcut"
"signal"
"skype"
"spotify"
"steam"
"temurin@8"
"timemachineeditor"
"unetbootin"
"utm"
"via"
"visual-studio-code"
"vlc"
"webex"
"yubico-authenticator"
"yubico-yubikey-manager"
"zoom"
)

echo Homebrew Casks
for val in ${cask_apps[@]}; do
	if ! brew ls --versions --cask $val > /dev/null; then
		brew install --cask $val
	fi
done

# gfxcardstatus

if [[ $(system_profiler SPDisplaysDataType | grep 'Chipset Model' | wc -l | xargs) != '1' ]]; then
	brew install --cask gfxcardstatus
fi

brew upgrade

read -p "Press enter to continue"
