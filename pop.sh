fix_ubuntu_18_04_sound_pop_issue(){
    __heredoc__="""
    Script that fixes a popping sound due to a power saving feature

    References:
        https://superuser.com/questions/1493096/linux-ubuntu-speakers-popping-every-few-seconds
        https://www.youtube.com/watch?v=Pdmy8dMWitg
    """
    sudo echo "obtaining sudo"
    # First, there are two system files that need modification
    # Changing the values here should fix the issue in your current session. 
    cat /sys/module/snd_hda_intel/parameters/power_save
    cat /sys/module/snd_hda_intel/parameters/power_save_controller
    # Flip the 1 to a 0
    sudo sh -c "echo 0 > /sys/module/snd_hda_intel/parameters/power_save"
    # Flip the Y to a N
    sudo sh -c "echo N > /sys/module/snd_hda_intel/parameters/power_save_controller"

    # To make this change persistant we must modify a config file
    if [ -f "/etc/default/tlp" ]; then
        # Some systems (usually laptops) have this controlled via TLP 
        sudo sed -i 's/SOUND_POWER_SAVE_ON_BAT=1/SOUND_POWER_SAVE_ON_BAT=0/' /etc/default/tlp
        # This line contained a typo, addressed on 2020-10-11 11:11 Bcn time
        sudo sed -i 's/SOUND_POWER_SAVE_CONTROLLER=Y/SOUND_POWER_SAVE_CONTROLLER=N/' /etc/default/tlp
    elif [ -f "/etc/modprobe.d/alsa-base.conf" ]; then
        # Append this line to the end of the file
        text="options snd-hda-intel power_save=0 power_save_controller=N"
        fpath="/etc/modprobe.d/alsa-base.conf"
        # Apppend the text only if it doesn't exist
        found="$(grep -F "$text" "$fpath")"
        if [ "$found" == "" ]; then
            sudo sh -c "echo \"$text\" >> $fpath"
        fi
        cat "$fpath"
    else
        echo "Error!, unknown system audio configuration" 1>&2
        exit 1
    fi
}
