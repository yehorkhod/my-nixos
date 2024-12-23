options=("default" "performance" "balance_performance" "balance_power" "power")

selected_option=$(printf "%s\n" "${options[@]}" | fzf --prompt="Choose a performance mode: " --height=10 --border --reverse)

if [ -n "$selected_option" ]; then
for cpu_path in /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference; do
  echo "$selected_option" > "$cpu_path"
done
  echo "CPU performance mode set to $selected_option"
else
  echo "No option selected. Exiting."
fi
