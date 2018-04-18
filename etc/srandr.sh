#!/usr/bin/env sh

Displays=""

while :; do
    if [[ $DISPLAY ]]; then
	CDisplays=$(xrandr | grep ' connected'   | awk '{print $1}')
	DDisplays=$(xrandr | grep 'disconnected' | awk '{print $1}')

	if [ "$Displays" != "$CDisplays" ]; then
            for display in $CDisplays; do
		if [ -e "$HOME/.display.sh" ]; then
		    . "$HOME/.display.sh"
		    for config in $DisplayConfigs; do
			if [ "$display" == "$config" ]; then
			    $config
			fi
		    done
		else
                    xrandr --output "$display" --auto
		fi
            done

	    for display in $DDisplays; do
		xrandr --output "$display" --off
            done

            Displays="$Connected"
	fi
    else
	sleep 5
    fi
done