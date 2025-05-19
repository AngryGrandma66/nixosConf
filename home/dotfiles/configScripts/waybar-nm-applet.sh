#!/usr/bin/env bash

ICON_CONNECTED=""    # nf-fa-signal
ICON_DISCONNECTED="" # nf-fa-times_circle
ICON_WIFI_OFF="睊"     # nf-mdi-wifi_off

# Get overall wifi state (enabled/disabled)
wifi_state=$(nmcli radio wifi)

if [[ "$wifi_state" != "enabled" ]]; then
    # Wi-Fi is off
    echo "{\"text\":\"$ICON_WIFI_OFF\",\"tooltip\":\"Wi-Fi disabled\",\"class\":\"disabled\"}"
    exit
fi

# Check if any device is connected
active_dev=$(nmcli -t -f DEVICE,STATE dev | grep '^.*:connected' | cut -d: -f1)
if [[ -z "$active_dev" ]]; then
    # No device connected
    echo "{\"text\":\"$ICON_DISCONNECTED\",\"tooltip\":\"Disconnected\",\"class\":\"disconnected\"}"
    exit
fi

# Get SSID and IP
ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes:' | cut -d: -f2)
ip=$(nmcli -t -f IP4.ADDRESS dev show "$active_dev" | cut -d: -f2 | cut -d/ -f1)

# You could also fetch signal strength if you like:
# strength=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep '^\*:' | cut -d: -f2)

echo "{\"text\":\"$ICON_CONNECTED  $ssid ($ip)\",\"tooltip\":\"$ssid @ $ip\",\"class\":\"connected\"}"

