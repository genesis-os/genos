#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="genos"
iso_label="genos_$(date +%Y%m)"
iso_publisher="Ege BALCI <http://www.github.com/egebalci>"
iso_application="Genesis OS linux distribution, based on Arch Linux."
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"

file_permissions=(
  ["/etc/shadow"]="0:0:0400"
  ["/etc/gshadow"]="0:0:0400"

  # /usr/local/bin  
  ["/usr/local/bin/apps_as_root.sh"]="1000:1000:0755"
  ["/usr/local/bin/askpass_rofi.sh"]="1000:1000:0755"
  ["/usr/local/bin/askpass_zenity.sh"]="1000:1000:0755"
  ["/usr/local/bin/backlight"]="1000:1000:0755"
  ["/usr/local/bin/backlight-down"]="1000:1000:0755"
  ["/usr/local/bin/backlight-up"]="1000:1000:0755"
  ["/usr/local/bin/battery"]="1000:1000:0755"
  ["/usr/local/bin/canvas_ob"]="1000:1000:0755"
  ["/usr/local/bin/change_font.sh"]="1000:1000:0755"
  ["/usr/local/bin/change_launcher.sh"]="1000:1000:0755"
  ["/usr/local/bin/change_powermenu.sh"]="1000:1000:0755"
  ["/usr/local/bin/change_style.sh"]="1000:1000:0755"
  ["/usr/local/bin/check-opsec"]="1000:1000:0755"
  ["/usr/local/bin/choose-mirror"]="1000:1000:0755"
  ["/usr/local/bin/colorbar-full"]="1000:1000:0755"
  ["/usr/local/bin/colorblocks"]="1000:1000:0755"
  ["/usr/local/bin/color_picker"]="1000:1000:0755"
  ["/usr/local/bin/crunchbang-small"]="1000:1000:0755"
  ["/usr/local/bin/fix_os_name.sh"]="1000:1000:0755"
  ["/usr/local/bin/kunst"]="1000:1000:0755"
  ["/usr/local/bin/lock"]="1000:1000:0755"
  ["/usr/local/bin/neofetch"]="1000:1000:0755"
  ["/usr/local/bin/nfetch"]="1000:1000:0755"
  ["/usr/local/bin/ob-compositor"]="1000:1000:0755"
  ["/usr/local/bin/ob-kb"]="1000:1000:0755"
  ["/usr/local/bin/ob-kb-pipemenu"]="1000:1000:0755"
  ["/usr/local/bin/ob-places-pipemenu"]="1000:1000:0755"
  ["/usr/local/bin/ob_powermenu"]="1000:1000:0755"
  ["/usr/local/bin/ob-recent-files-pipemenu"]="1000:1000:0755"
  ["/usr/local/bin/os_name.sh"]="1000:1000:0755"
  ["/usr/local/bin/panes"]="1000:1000:0755"
  ["/usr/local/bin/pipes-1"]="1000:1000:0755"
  ["/usr/local/bin/pipes-2"]="1000:1000:0755"
  ["/usr/local/bin/pipes-3"]="1000:1000:0755"
  ["/usr/local/bin/randomize_dhcp_hostnames"]="1000:1000:0755"
  ["/usr/local/bin/shotArea"]="1000:1000:0755"
  ["/usr/local/bin/shotin10"]="1000:1000:0755"
  ["/usr/local/bin/shotin5"]="1000:1000:0755"
  ["/usr/local/bin/shotnow"]="1000:1000:0755"
  ["/usr/local/bin/shotWindow"]="1000:1000:0755"
  ["/usr/local/bin/tasks"]="1000:1000:0755"
  ["/usr/local/bin/volume"]="1000:1000:0755"
  ["/usr/local/bin/volume-down"]="1000:1000:0755"
  ["/usr/local/bin/volume-up"]="1000:1000:0755"
  ["/usr/local/bin/xflock4"]="1000:1000:0755"


  # ~/.config/bspwm
  ["/home/liveuser/.config/bspwm/bspwmrc"]="1000:1000:0755"
  ["/home/liveuser/.config/bspwm/bin/apps_as_root"]="1000:1000:0755" 
  ["/home/liveuser/.config/bspwm/bin/askpass"]="1000:1000:0755" 
  ["/home/liveuser/.config/bspwm/bin/bspbar"]="1000:1000:0755" 
  ["/home/liveuser/.config/bspwm/bin/bspcolors"]="1000:1000:0755" 
  ["/home/liveuser/.config/bspwm/bin/bspcomp"]="1000:1000:0755" 
  ["/home/liveuser/.config/bspwm/bin/bspfloat"]="1000:1000:0755" 
  ["/home/liveuser/.config/bspwm/bin/bspterm"]="1000:1000:0755" 
  ["/home/liveuser/.config/bspwm/bin/winmask"]="1000:1000:0755" 

  # .config/polybar
  ["/home/liveuser/.config/polybar/*/launch.sh"]="1000:1000:0755"
  ["/home/liveuser/.config/polybar/launch.sh"]="1000:1000:0755"
  ["/home/liveuser/.config/polybar/fix_modules.sh"]="1000:1000:0755"

  # .config/rofi
  ["/home/liveuser/.config/rofi/bin/*"]="1000:1000:0755"


)