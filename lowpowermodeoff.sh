#!/bin/bash
if [[ $(uname -m) == 'arm64' ]]; then
	sudo pmset -a powermode 0
else
	sudo pmset -a lowpowermode 0
fi