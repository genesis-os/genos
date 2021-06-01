#!/usr/bin/env bash
#
# SPDX-License-Identifier: GPL-3.0-or-later

## Pre-build script for archcraft OS.

## ANSI Colors (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"

## Directories
DIR="$(pwd)"

## Build mode
BUILD_MODE=$1

## Banner
banner () {
        banner_b64="CgoJIOKWiOKWiOKWiOKWiOKWiOKWiOKVlyDilojilojilojilojilojilojilojilZfilojilojilojilZcgICDilojilojilZcg4paI4paI4paI4paI4paI4paI4pWXIOKWiOKWiOKWiOKWiOKWiOKWiOKWiOKVlwoJ4paI4paI4pWU4pWQ4pWQ4pWQ4pWQ4pWdIOKWiOKWiOKVlOKVkOKVkOKVkOKVkOKVneKWiOKWiOKWiOKWiOKVlyAg4paI4paI4pWR4paI4paI4pWU4pWQ4pWQ4pWQ4paI4paI4pWX4paI4paI4pWU4pWQ4pWQ4pWQ4pWQ4pWdCgnilojilojilZEgIOKWiOKWiOKWiOKVl+KWiOKWiOKWiOKWiOKWiOKVlyAg4paI4paI4pWU4paI4paI4pWXIOKWiOKWiOKVkeKWiOKWiOKVkSAgIOKWiOKWiOKVkeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKVlwoJ4paI4paI4pWRICAg4paI4paI4pWR4paI4paI4pWU4pWQ4pWQ4pWdICDilojilojilZHilZrilojilojilZfilojilojilZHilojilojilZEgICDilojilojilZHilZrilZDilZDilZDilZDilojilojilZEKCeKVmuKWiOKWiOKWiOKWiOKWiOKWiOKVlOKVneKWiOKWiOKWiOKWiOKWiOKWiOKWiOKVl+KWiOKWiOKVkSDilZrilojilojilojilojilZHilZrilojilojilojilojilojilojilZTilZ3ilojilojilojilojilojilojilojilZEKCeKVmuKVkOKVkOKVkOKVkOKVkOKVnSDilZrilZDilZDilZDilZDilZDilZDilZ3ilZrilZDilZ0gIOKVmuKVkOKVkOKVkOKVnSDilZrilZDilZDilZDilZDilZDilZ0g4pWa4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWdCi0uXyAgICBfLi0tJyJgJy0tLl8gICAgXy4tLSciYCctLS5fICAgIF8uLS0nImAnLS0uXyAgICBfICAgCiAgICAnLTpgLid8YHwiJzotLiAgJy06YC4nfGB8Iic6LS4gICctOmAuJ3xgfCInOi0uICAnLmAgOiAnLiAgIAogICcuICAnLiAgfCB8ICB8IHwnLiAgJy4gIHwgfCAgfCB8Jy4gICcuICB8IHwgIHwgfCcuICAnLjogICAnLiAgJy4KICA6ICcuICAnLnwgfCAgfCB8ICAnLiAgJy58IHwgIHwgfCAgJy4gICcufCB8ICB8IHwgICcuICAnLiAgOiAnLiAgYC4KICAnICAgJy4gIGAuOl8gfCA6Xy4nICcuICBgLjpfIHwgOl8uJyAnLiAgYC46XyB8IDpfLicgJy4gIGAuJyAgIGAuCiAgICAgICAgIGAtLi4sLi4tJyAgICAgICBgLS4uLC4uLScgICAgICAgYC0uLiwuLi0nICAgICAgIGAgICAgICAgICBgCg=="
    clear
    cat <<- _EOF_
                ${RED}          
                `echo $banner_b64|base64 -d`
										
			${ORANGE}[*] ${CYAN}By: Ege BALCI
			${ORANGE}[*] ${CYAN}Github: @egebalci
			${ORANGE}[*] ${CYAN}Twitter: @egeblc
_EOF_

}

## Reset terminal colors
reset_color() {
	tput sgr0   # reset attributes
	tput op     # reset color
    return
}

print_status() {
	echo -n ${ORANGE}"[*] "
	reset_color
	echo $1  
}

print_error() {
	echo -n ${RED}"[-] "
	reset_color
	echo $1
}

print_fatal() {
	echo -e ${RED}"\n[!] $1\n"
	reset_color
	exit
}


print_good() {
	echo -n ${GREEN}"[+] "
	reset_color
	echo $1
}

## Script Termination
exit_on_signal_SIGINT () {
    print_fatal "Script interrupted."
    exit 0
}

exit_on_signal_SIGTERM () {
    print_fatal "Script terminated."
    exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Install build dependencies
install_build_deps() {
	sudo pacman -S extra-cmake-modules qt5-tools qt5-translations git boost
	yay -S mkinitcpio-openswap ckbcomp
}


## Prerequisite
prerequisite() {
	print_status "We need to clear pacman cache, !!! please remove all cache files !!!"
	echo -e "\n"
	sudo pacman -Scc
	echo -e "\n"

	print_status "Installing Dependencies..."
	print_status "Installing latest oh-my-zsh..."
	git clone --depth=1 --branch master https://github.com/ohmyzsh/ohmyzsh.git "$DIR/iso/airootfs/etc/skel/.oh-my-zsh" >>/tmp/.genos_setup.log 2>&1
	print_status "Installing latest powerlevel10k..."
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$DIR/iso/airootfs/etc/skel/.oh-my-zsh/custom/themes/powerlevel10k" >>/tmp/.genos_setup.log 2>&1
	print_status "Installing vundle..."
	git clone https://github.com/VundleVim/Vundle.vim.git "$DIR/iso/airootfs/etc/skel/.vim/bundle/Vundle.vim" >>/tmp/.genos_setup.log 2>&1
	print_status "Installing mkarchiso..."
	if [[ -f /usr/bin/mkarchiso ]]; then
		print_good "mkarchiso already Installed!"
	else
		sudo pacman -Sy archiso --noconfirm
		if type -p mkarchiso &> /dev/null; then 
			print_good "All dependencies are succesfully installed!";
		else
			print_error "Error Occured, failed to install mkarchiso."
			exit 1
		fi
	fi
	# print_status "Modifying /usr/bin/mkarchiso ..."
	# sudo cp -f /usr/bin/mkarchiso $DIR/iso/mkgenosiso && sudo sed -i -e 's/-c -G -M/-i -c -G -M/g' $DIR/iso/mkgenosiso
	# sudo sed -i -e 's/--no-preserve=ownership,mode/--no-preserve=ownership/g' $DIR/iso/mkgenosiso
	# sudo sed -i -e 's/archiso-x86_64/genos-x86_64/g' /usr/bin/mkgenosiso
	print_good "Succesfully Modified."

	if [[ $BUILD_MODE == "--full" ]]; then
		sed -i 's|^# ||g' $DIR/iso/packages.x86_64
		print_good "Package list reconfigured for full setup."

	else
		print_good "Package list configured for lite setup."
	fi

}

## Changing ownership to root to avoid false permissions error
set_mod () {
	print_status "Setting up correct permissions..."
	# sudo sed -i -e 's/--no-preserve=ownership,mode/--no-preserve=ownership/g' /usr/bin/mkgenosiso
	sudo chown -R root:root $DIR/iso/
	print_good "Setup Completed, follow the next step to build the ISO."
}

build_aur_packages() {
	print_status "Building nessesary AUR packages..."
	print_status "This step takes lots of time, so go grab a coffee or something :)"
	
	mkdir -p $DIR/iso/airootfs/opt
	mkdir -p $DIR/iso/airootfs/opt/aur-packages
	mkdir -p $DIR/iso/airootfs/opt/aur-packages/x86_64


	aur_packages=("yay" "polybar" "plymouth" "i3lock-color" "blight" "networkmanager-dmenu-git" "mkinitcpio-openswap" "ckbcomp") # "grub-silent"

	for package in "${aur_packages[@]}";
	do
		print_status "Building $package ..."
		git clone "https://aur.archlinux.org/$package.git" "/tmp/$package" >>/tmp/.genos_setup.log 2>&1
		cd "/tmp/$package"
		makepkg -s --noconfirm >>/tmp/.genos_setup.log 2>&1
		if [ ! -f  *.pkg.tar.* ]; then
			print_error "$package install failed!"
			print_fatal "Aborting..."
			cd - >>/tmp/.genos_setup.log 2>&1
			rm -rf "/tmp/$package"
			exit 1
		fi
		cp *.pkg.tar.* $DIR/iso/airootfs/opt/aur-packages/x86_64/ >>/tmp/.genos_setup.log 2>&1
		cd - >>/tmp/.genos_setup.log 2>&1
		rm -rf "/tmp/$package"
	done


	genos_packages=("genos-calamares-installer" "genos-chkopsec" "genos-desktop-openbox" "genos-lxdm-theme" "genos-plymouth-theme" "genos-wallpapers")

	print_status "Building custom genos packages..."
	for package in "${genos_packages[@]}";
	do
		print_status "Building $package ..."
		git clone "https://github.com/genesis-os/$package.git" "/tmp/$package" >>/tmp/.genos_setup.log 2>&1
		cd "/tmp/$package"
		makepkg -s --noconfirm --skipinteg >>/tmp/.genos_setup.log 2>&1
		if [ ! -f  *.pkg.tar.* ]; then
			print_error "$package install failed!"
			print_fatal "Aborting..."
			cd - >>/tmp/.genos_setup.log 2>&1
			rm -rf "/tmp/$package"
			exit 1
		fi
		cp *.pkg.tar.* $DIR/iso/airootfs/opt/aur-packages/x86_64/ >>/tmp/.genos_setup.log 2>&1
		cd - >>/tmp/.genos_setup.log 2>&1
		rm -rf "/tmp/$package"
	done

	repo-add $DIR/iso/airootfs/opt/aur-packages/x86_64/custom.db.tar.gz $DIR/iso/airootfs/opt/aur-packages/x86_64/*.pkg.tar.* >>/tmp/.genos_setup.log 2>&1	
	if [ ! -f $DIR/iso/airootfs/opt/aur-packages/x86_64/custom.db ]; then
		ln -s $DIR/iso/airootfs/opt/aur-packages/x86_64/custom.db /opt/aur-packages/x86_64/custom.db.tar.gz
	fi

	cd $DIR
	if ! grep -q "$DIR/iso/airootfs/opt/" $DIR/iso/pacman.conf; then
		sed -i "s|\/opt\/|$DIR\/iso\/airootfs\/opt\/|g" $DIR/iso/pacman.conf 
	fi

	print_good "AUR package builds completed!"

	print_status "Changing the default plymoth theme..."
	print_good "All done"
}

## Main
banner
prerequisite
build_aur_packages
set_mod
exit 0
