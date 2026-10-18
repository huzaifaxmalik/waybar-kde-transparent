#!/usr/bin/env bash
source "$(dirname "$0")/_q.sh"
$Q org.kde.KWin /KWin org.kde.KWin.setCurrentDesktop "$1"
