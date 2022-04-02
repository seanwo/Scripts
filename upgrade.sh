#!/bin/bash
source ~/Scripts/local_casks.sh
/usr/local/bin/brew update --quiet
/usr/local/bin/brew upgrade
/usr/local/bin/brew cu -a -y
/usr/local/bin/brew upgrade --cask ~/Scripts/filezilla.rb
/usr/local/bin/mas upgrade
