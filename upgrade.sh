#!/bin/bash

export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_ASK=1

echo Running local cask update script
source ~/Scripts/local_casks.sh

echo Updating Brew
brew update --quiet

echo Updating Brew formulae
brew upgrade --formula

echo Updating Brew casks
brew upgrade --cask --greedy

echo Updating App Store apps
mas upgrade

echo Done.
