#!/bin/bash
cp rc.lua ~/.config/awesome/
cp theme.lua ~/.config/awesome/themes/multicolor/
 if [[ -z "$DBUS_SESSION_BUS_ADDRESS" ]]; then # Looks like we are outside X
     eval $(tr '\0' '\n' < /proc/$(pgrep awesome | head -1 )/environ | sed -e 's/^/export /') #export all environment variables
 fi
echo 'awesome.restart()' | /usr/bin/awesome-client
