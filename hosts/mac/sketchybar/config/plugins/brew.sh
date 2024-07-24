#!/bin/bash

CONFIG_DIR=$(
	cd "$(dirname "${BASH_SOURCE[0]}")" || exit
	pwd -P
)
CONFIG_DIR="$CONFIG_DIR/../"

source "$CONFIG_DIR/colors.sh"

COUNT=$(brew outdated | wc -l | tr -d ' ')

COLOR=$RED

case "$COUNT" in
  [3-5][0-9]) COLOR=$ORANGE
  ;;
  [1-2][0-9]) COLOR=$YELLOW
  ;;
  [1-9]) COLOR=$WHITE
  ;;
  0) COLOR=$GREEN
     COUNT=􀆅
  ;;
esac

sketchybar --set $NAME label=$COUNT icon.color=$COLOR
