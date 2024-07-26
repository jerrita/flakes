#!/usr/bin/env sh

UPDOWN=$(ifstat-legacy -i "en0" -b 1 1 | tail -n1)
DOWN=$(echo $UPDOWN | awk '{ print $1 }' | cut -f1 -d ".")
UP=$(echo $UPDOWN | awk '{ print $2 }' | cut -f1 -d ".")

# Format download speed
if [ "$DOWN" -gt "8192" ]; then
  DOWN_FORMAT=$(echo "scale=2; $DOWN / 8192" | bc)
  DOWN_FORMAT=$(printf "%6.2f MB/s" $DOWN_FORMAT)
else
  DOWN_FORMAT=$(echo "scale=2; $DOWN / 8" | bc)
  DOWN_FORMAT=$(printf "%6.2f KB/s" $DOWN_FORMAT)
fi

# Format upload speed
if [ "$UP" -gt "8192" ]; then
  UP_FORMAT=$(echo "scale=2; $UP / 8192" | bc)
  UP_FORMAT=$(printf "%6.2f MB/s" $UP_FORMAT)
else
  UP_FORMAT=$(echo "scale=2; $UP / 8" | bc)
  UP_FORMAT=$(printf "%6.2f KB/s" $UP_FORMAT)
fi

sketchybar -m --set network_down label="$DOWN_FORMAT" icon.highlight=$(if [ "$DOWN" -gt "0" ]; then echo "on"; else echo "off"; fi) \
                    --set network_up label="$UP_FORMAT" icon.highlight=$(if [ "$UP" -gt "0" ]; then echo "on"; else echo "off"; fi)

