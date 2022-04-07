#!/bin/bash
source ~/Scripts/local_casks.sh
brew update --quiet
brew upgrade
brew cu -a -y
brew upgrade --cask ~/Scripts/filezilla.rb
mas upgrade
