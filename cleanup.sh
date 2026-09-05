#!/bin/bash

echo Running Brew autoremove
brew autoremove

echo Running Brew cleanup
brew cleanup

echo Running Brew doctor
brew doctor

echo Done.
