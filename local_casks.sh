#!/bin/bash
version=$(eval "curl -s https://filezilla-project.org/download.php?show_all=1 | grep \"The latest stable version of FileZilla Client is \" | grep -Eo '[0-9]{1,3}(\.[0-9]{1,3}){0,10}'")
cask=~/Scripts/filezilla.rb
sed -i -e "s/version \'.*\'/version \'$version\'/g" $cask
