# Current Theme
dir="/home/yehorkhod/System/homeModules/waybar/powermenu/"
theme='style'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"

# Options
shutdown='shutdown'
reboot='reboot'
suspend='suspend'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Uptime: $uptime" \
		-mesg "Uptime: $uptime" \
		-theme ${dir}/${theme}.rasi
}


# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$suspend\n$reboot\n$shutdown" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $suspend)
		systemctl suspend
        ;;
esac

