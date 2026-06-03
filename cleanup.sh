#!/bin/bash
export HOMEBREW_NO_REQUIRE_TAP_TRUST=1
brew cleanup
brew autoremove
brew doctor
