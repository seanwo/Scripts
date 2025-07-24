#!/bin/bash

# Path to Chrome on macOS M1
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
URL="https://filezilla-project.org/download.php?show_all=1"
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36"

# Run Chrome headless and capture rendered DOM
html=$("$CHROME" \
  --headless \
  --disable-gpu \
  --log-level=3 \
  --user-agent="$UA" \
  --dump-dom "$URL")

# Extract version number
version=$(echo "$html" | grep "The latest stable version of FileZilla Client is" | grep -Eo '[0-9]{1,3}(\.[0-9]{1,3}){0,10}')

# Choose the correct package file (ARM or Intel)
package="macos-arm64.app.tar.bz2"
# package="macos-x86.app.tar.bz2"

# Extract .tar.bz2 URL from Chrome-rendered DOM
rawurl=$(echo "$html" | grep -oE 'https://dl[0-9]+\.cdn\.filezilla-project\.org/client/FileZilla_[0-9.]+_macos-arm64\.app\.tar\.bz2\?[^"]*' | head -n1)

# Fix HTML encoding
downloadurl=$(echo "$rawurl" | sed 's/&amp;/\&/g')

# Path to your Homebrew cask file
cask=~/Scripts/filezilla.rb

# Escape ampersands for sed replacement
sed_safe_url=$(printf '%s\n' "$downloadurl" | sed 's/&/\\\&/g')

# Update version and URL in the cask file
sed -i -e "s/version \'.*\'/version \'$version\'/g" "$cask"
sed -i '' "s|\( *\)url \"\"|\1url \"$sed_safe_url\"|" "$cask"