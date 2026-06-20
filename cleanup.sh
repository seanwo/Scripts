#!/bin/bash

export HOMEBREW_NO_REQUIRE_TAP_TRUST=1

echo Running Brew autoremove
brew autoremove

echo Running Brew cleanup
brew cleanup

echo Running Brew doctor
brew doctor

echo Done.