#!/usr/bin/env bash

## run (only once) processes which spawn with the same name
function run {
   if (command -v $1 && ! pgrep $1); then
     $@&
   fi
}

run xmodmap -e "keycode 127 = Space"
run xmodmap -e "keycode 107 = Next"
run xmodmap -e "keycode 112 = Scroll_Lock"
run xmodmap -e "keycode 78 = Prior"
run xmodmap -e "keycode 117 = Insert"
run xmodmap -e "keycode 118 = Print"
run nm-applet
run pasystray
run steam
run element-desktop
run picom
run blueman-applet
run nitrogen --restore
run xbindkeys
run mount -a
