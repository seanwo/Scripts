#!/bin/bash
export HOMEBREW_NO_REQUIRE_TAP_TRUST=1
source ~/Scripts/local_casks.sh
brew update --quiet
brew upgrade
brew cu -a -y
mas upgrade
