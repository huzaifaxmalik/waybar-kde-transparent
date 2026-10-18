#!/usr/bin/env bash
# usage: ws.sh N  -> prints "Desktop N" (hidden if desktop N doesn't exist)
source "$(dirname "$0")/_q.sh"
i=$1
cur=$($Q org.kde.KWin /KWin org.kde.KWin.currentDesktop 2>/dev/null)
n=$($Q org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.count 2>/dev/null)
cur=${cur:-1}; n=${n:-1}
if [ "$i" -gt "$n" ]; then echo '{"text":""}'; exit; fi
if [ "$i" -eq "$cur" ]; then
  echo "{\"text\":\"Desktop $i\",\"class\":\"active\"}"
else
  echo "{\"text\":\"Desktop $i\"}"
fi
