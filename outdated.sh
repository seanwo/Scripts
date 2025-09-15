#!/bin/bash
source ~/Scripts/local_casks.sh
brew update --quiet
brew outdated --greedy --verbose | grep "(latest) != latest" -v
mas outdated
/usr/sbin/softwareupdate --list 
