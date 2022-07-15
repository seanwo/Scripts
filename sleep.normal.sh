#!/bin/bash
sudo pmset -a sleep 60
sudo pmset -a disksleep 30
sudo pmset -a displaysleep 20
sudo pmset -a womp 1
sudo pmset -a hibernatemode 3
sudo pmset -a powernap 0
if [[ $(uname -m) != 'arm64' ]]; then
	sudo pmset -a lidwake 1
	sudo pmset -a acwake 0
	sudo pmset -a gpuswitch 2
fi
