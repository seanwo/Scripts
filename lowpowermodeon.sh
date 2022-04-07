#!/bin/bash
if [[ $(uname -m) == 'arm64' ]]; then
	sudo pmset -a powermode 1
else
	sudo pmset -a lowpowermode 1
fi