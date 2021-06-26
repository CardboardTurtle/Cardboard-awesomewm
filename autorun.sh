#!/usr/bin/env bash

## run (only once) processes which spawn with the same name
function run {
   if (command -v $1 && ! pgrep $1); then
     $@&
   fi
}

xinput set-prop 19 336 -0.77
xinput set-prop "USB-HID Keyboard Mouse" 336 -0.77
xmodmap -e "keycode 127 = space"
xmodmap -e "keycode 115 = Insert"
xmodmap -e "keycode 110 = Scroll_Lock"
xmodmap -e "keycode 118 = Print"
xmodmap -e "keycode 107 = Next"
xmodmap -e "keycode 78 = Prior"
xmodmap -e "keycode 117 = End"
xmodmap -e "keycode 112 = Home"
xbindkeys --poll-rc
run nm-applet
run pasystray
run hblock
run steam
run element-desktop
run picom
run blueman-applet
run nitrogen --restore
run mount -a
