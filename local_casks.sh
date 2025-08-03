#!/bin/bash

# Path to Chrome on macOS (M1 or Intel)
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Target page to scrape
URL="https://filezilla-project.org/download.php?show_all=1"

# User agent to simulate real browser traffic
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36"

# Run Chrome headless and capture the rendered DOM while suppressing media/sandbox-related warnings
html=$("$CHROME" \
  --headless \
  --disable-gpu \
  --disable-speech-api \
  --mute-audio \
  --disable-software-rasterizer \
  --disable-dev-shm-usage \
  --log-level=3 \
  --user-agent="$UA" \
  --dump-dom "$URL"
)

# Extract the latest version number of FileZilla from the rendered DOM
version=$(echo "$html" | grep "The latest stable version of FileZilla Client is" | grep -Eo '[0-9]{1,3}(\.[0-9]{1,3}){0,10}')

# Define the architecture-specific package (ARM in this case)
package="macos-arm64.app.tar.bz2"
# For Intel Macs, uncomment the line below:
# package="macos-x86.app.tar.bz2"

# Extract the correct download URL for the specified package
rawurl=$(echo "$html" | grep -oE "https://dl[0-9]+\.cdn\.filezilla-project\.org/client/FileZilla_[0-9.]+_${package//./\\.}\\?[^\"']+" | head -n1)

# Decode HTML entities
downloadurl=$(echo "$rawurl" | sed 's/&amp;/\&/g')

# Output results (for debugging)
# echo "Latest FileZilla Version: $version"
# echo "Download URL: $downloadurl"