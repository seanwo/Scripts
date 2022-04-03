#!/bin/bash
open -a "AndroidMessages"
open -a Signal
sleep 30
osascript -e 'tell application "system events" to set visible of application process "AndroidMessages" to false'
osascript -e 'tell application "system events" to set visible of application process "Signal" to false'
