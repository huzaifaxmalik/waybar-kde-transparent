#!/usr/bin/env bash
# usage: switch.sh next|prev
source "$(dirname "$0")/_q.sh"
cur=$($Q org.kde.KWin /KWin org.kde.KWin.currentDesktop)
n=$($Q org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.count)
if [ "$1" = "next" ]; then t=$(( cur % n + 1 )); else t=$(( (cur + n - 2) % n + 1 )); fi
$Q org.kde.KWin /KWin org.kde.KWin.setCurrentDesktop "$t"
