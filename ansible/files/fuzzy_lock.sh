#!/bin/sh -e

# Take a screenshot
scrot /tmp/screen_locked.png

# Pixellate it 10x
mogrify -scale 10% -scale 1000% /tmp/screen_locked.png
#convert /tmp/screen_locked.png -blur 0x8 -channel RGBA /tmp/screen_locked.png

# Lock screen displaying this image.
swaylock -i /tmp/screen_locked.png

# Turn the screen off after a delay.
sleep 60; pgrep swaylock && xset dpms force off
