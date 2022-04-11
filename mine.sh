#!/bin/bash

#launch powermetrics
osascript -e 'tell app "Terminal"
    do script "sudo powermetrics"
	set custom title of window 1 to "powermetrics"  
end tell'

#launch ethermine
osascript -e 'tell app "Terminal"
    do script "ethermine.sh"
	set custom title of window 1 to "ethermine"  
end tell'

#launch ethermine dashboard
osascript -e 'tell application "Google Chrome"
	activate
	open location "https://ethermine.org/miners/2C45B25C7811c82117D0f4C47030EeC921575812/dashboard"
    delay 1
    activate
end tell'

#arrange windows

if [[ "$1" == "top" ]]
then
	osascript -e 'tell application "Terminal"
		activate
		set the bounds of the third window to {893, 449, 1757, 988}
		set the bounds of the first window to {1323, 25, 2559, 732}
		set the bounds of the second window to {1323, 733, 2559, 1440}
	end tell'

	osascript -e 'tell application "Google Chrome"
		activate
		set the bounds of the first window to {85, 25, 1322, 1440}
	end tell'
else
	osascript -e 'tell application "Terminal"
		activate
		set the bounds of the third window to {464, 326, 1328, 865}
		set the bounds of the first window to {906, 38, 1728, 577}
		set the bounds of the second window to {906, 578, 1728, 1117}
	end tell'

	osascript -e 'tell application "Google Chrome"
		activate
		set the bounds of the first window to {84, 38, 906, 1117}
	end tell'
fi