#!/usr/bin/env bash
#
# waybar-nm-applet.sh — a simple NMCLI-based module for Waybar

ICON_CONNECTED=""    # nf-fa-signal
ICON_DISCONNECTED="" # nf-fa-times_circle
ICON_WIFI_OFF="睊"     # nf-mdi-wifi_off

# 1) Wi-Fi on/off?
wifi_state=$(nmcli radio wifi)
if [[ "$wifi_state" != "enabled" ]]; then
    echo "{\"text\":\"$ICON_WIFI_OFF\",\"tooltip\":\"Wi-Fi disabled\",\"class\":\"disabled\"}"
    exit
fi

# 2) Pick only Wi-Fi devices in the “connected” state
active_dev=$(nmcli -t -f DEVICE,TYPE,STATE dev \
  | awk -F: '$2=="wifi" && $3=="connected" { print $1 }')

if [[ -z "$active_dev" ]]; then
    echo "{\"text\":\"$ICON_DISCONNECTED\",\"tooltip\":\"Disconnected\",\"class\":\"disconnected\"}"
    exit
fi

# 3) Pull SSID & IP
ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2}')
ip=$(nmcli -t -f IP4.ADDRESS dev show "$active_dev" \
     | cut -d: -f2 | cut -d/ -f1)

echo "{\"text\":\"$ICON_CONNECTED  $ssid ($ip)\",\"tooltip\":\"$ssid @ $ip\",\"class\":\"connected\"}"

