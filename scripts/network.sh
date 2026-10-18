#!/usr/bin/env bash
# Waybar network module (NetworkManager):
#   wifi : <ifname red> <wifi icon white> <SSID red> <signal %, colour by strength>
RED="#ff4d4d"; WHITE="#ffffff"
SZ="size='14336'"
ICON_WIFI=" "; ICON_ETH=" "; ICON_OFF=" "

esc() {  # escape for JSON + pango markup
  sed -e 's/\\/\\\\/g' -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' \
      -e "s/'/\&#39;/g" -e 's/"/\&quot;/g'
}
span() { printf "<span color='%s' weight='bold'>%s</span>" "$1" "$2"; }
icon() { printf "<span color='%s' %s>%s</span>" "$1" "$SZ" "$2"; }

wifi=$(nmcli -t -e no -f ACTIVE,SIGNAL,DEVICE,SSID dev wifi list --rescan no 2>/dev/null | grep '^yes:' | head -n1)

if [ -n "$wifi" ]; then
  sig=$(cut -d: -f2 <<<"$wifi")
  dev=$(cut -d: -f3 <<<"$wifi" | esc)
  ssid=$(cut -d: -f4- <<<"$wifi" | esc)
  # signal colour: green >=70 | yellow >=40 | orange >=20 | red <20
  if   [ "$sig" -ge 70 ]; then col="#3ddc84"
  elif [ "$sig" -ge 40 ]; then col="#ffd60a"
  elif [ "$sig" -ge 20 ]; then col="#ff9f1a"
  else col="$RED"; fi
  text="$(span $RED "$dev") $(icon $WHITE "$ICON_WIFI") $(span $RED "$ssid") $(span $col "$sig%")"
else
  eth=$(nmcli -t -e no -f DEVICE,TYPE,STATE dev 2>/dev/null | awk -F: '$2=="ethernet" && $3=="connected"{print $1; exit}')
  if [ -n "$eth" ]; then
    text="$(span $RED "$(esc <<<"$eth")") $(icon $WHITE "$ICON_ETH")"
  else
    text="$(icon $WHITE "$ICON_OFF") $(span $RED "Off")"
  fi
fi

printf '{"text":"%s","tooltip":false}\n' "$text"
