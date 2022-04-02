#!/bin/bash
open -a "Android Messages"
open -a Signal
sleep 30
osascript -e 'tell application "system events" to set visible of application process "Android Messages" to false'
osascript -e 'tell application "system events" to set visible of application process "Signal" to false'
