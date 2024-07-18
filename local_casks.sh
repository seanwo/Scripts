#!/bin/bash
version=$(eval "curl -A \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36\" -s https://filezilla-project.org/download.php?show_all=1 | grep \"The latest stable version of FileZilla Client is \" | grep -Eo '[0-9]{1,3}(\.[0-9]{1,3}){0,10}'")
package="macos-arm64.app.tar.bz2"
#package="macos-x86.app.tar.bz2"
downloadurl=$(eval "curl -A \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36\" -s https://filezilla-project.org/download.php?show_all=1 | grep \"a href\" | grep \"$package\" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_&%:-]*'")
encodeurl=`printf "%q" $downloadurl`
cask=~/Scripts/filezilla.rb
sed -i -e "s/version \'.*\'/version \'$version\'/g" $cask
sed -i -e "s@url \".*\"@url \"$encodeurl\"@g" $cask
