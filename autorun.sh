#!/usr/bin/env bash

## run (only once) processes which spawn with the same name
function run {
   if (command -v $1 && ! pgrep $1); then
     $@&
   fi
}


run xmodmap -e "keycode 94 = Super_L"
run nm-applet
run pasystray
run steam
run element-desktop
run picom
run blueman-applet
run nitrogen --restore
