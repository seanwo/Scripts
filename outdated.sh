#!/bin/bash
source ~/Scripts/local_casks.sh
/usr/local/bin/brew update --quiet
/usr/local/bin/brew outdated --greedy --verbose | grep "(latest) != latest" -v
/usr/local/bin/brew outdated --cask ~/Scripts/filezilla.rb
/usr/local/bin/mas outdated
/usr/sbin/softwareupdate --list 
