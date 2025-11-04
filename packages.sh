#!/usr/bin/env bash

# installs commonly used linux tools

set -euo pipefail

INVOKER="${SUDO_USER:-${USER:-unknown}}"

PACKAGES=(
	sudo
	curl
	wget
	git
	htop             # htop/btop
	less             # file pager
	vim              # optional fallback
	man-db
	file
	tree
	rsync  		     # sync/backup files
	xclip xsel       # clipboard
	arandr
    brightnessctl    # tool for controlling system brightness
    light
    xbacklight

	iproute2         # command; ip
	net-tools        # command; ifconfig netstat
	iputils-ping     # command; ping (network test tool)
	traceroute       # exe (diagnose network paths)
	mtr              # ping + traceroute
	dnsutils         # command; dig, nslookup (DNS testing)
	nmap             # network scanning/discovery
	tcpdump          # network traffic capture/dump
	hwinfo           # hardware info

	build-essential  # GCC, make, libraries
	cmake			 # build system generator
	gdb				 # debugger
	python3          # scripting
	python3-pip      # package manager

	fuse3            # kernel userspace for AppImages
	libfuse2         # compatibility library for older FUSE

	unzip
	zip
	# rar
	unrar-free

	pavucontrol
	pulseaudio
	pulseaudio-utils

	ripgrep
	fd-find          # modern 'find' command
	fzf              # fuzzy file search
	bat              # cat + syntax highlighting
	tmux

    pass             # password storage
	timeshift        # system store point management
	qimgv            # image viewer (optional video support?)
	# gimp
	# inkscape
	# libreoffice (?)
	# obs
)

if [ "$(id -u)" -ne 0 ]; then
	echo "Please run this script with sudo."
	echo "    sudo $0"
	exit 1
fi

export DEBIAN_FRONTEND=noninteractive

echo "Updating Package List..."
apt-get update -y

echo "Installing Packages..."
apt-get install -y "${PACKAGES[@]}"

# FUSE
if ! getend group fuse >/dev/null; then
	echo "Creating group 'fuse'"
	groupadd fuse || true
fi

if [ -n "$INVOKER" ] && [ "$INVOKER" != "root" ]; then
	echo "Adding user '$INVOKER' to 'fuse' group"
	usermod -aG fuse "$INVOKER" || true
fi

# attempt to fix fd-find
ln -s $(which fdfind) :"~/.local/bin/fd"

modprobe fuse || true

if sytemctl list-unit-files ssh.service >/dev/null 2>&1; then
	echo "Enabling and starting ssh.service"
	systemctl enable --now ssh.service || true
fi

echo "Installation Complete, reboot to finalize/add users to groups."
