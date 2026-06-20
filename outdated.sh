#!/bin/bash

export HOMEBREW_NO_REQUIRE_TAP_TRUST=1

echo Running local cask update script
source ~/Scripts/local_casks.sh

echo Updating Brew
brew update --quiet

echo Checking for outdated Brew formulae
brew outdated --formula --verbose

echo Checking for outdated Brew casks
brew outdated --cask --greedy --verbose | grep "(latest) != latest" -v

echo Checking for outdated App Store apps
mas outdated

echo Checking for MacOS updates
/usr/sbin/softwareupdate --list

echo Done.