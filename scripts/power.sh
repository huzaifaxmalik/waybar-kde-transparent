#!/usr/bin/env bash
# KDE's native shutdown / logout / reboot dialog
source "$(dirname "$0")/_q.sh"
$Q org.kde.LogoutPrompt /LogoutPrompt org.kde.LogoutPrompt.promptShutDown
