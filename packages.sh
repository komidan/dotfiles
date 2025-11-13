#!/usr/bin/env bash

set -euo pipefail

# Comment out packages if you don't want them!

# REQUIRED
PACKAGES_REQUIRED=(
    sudo
)

# SYSTEM PACKAGES: I suggest intalling these.
PACKAGES_SYSTEM=(
    curl
    wget
    btop             # htop alternative, system monitoring tool
    less
    vim              # neovim backup for sudo editing, nano sucks
    hwinfo           # hardware info
    fuse
    libfuse2
    timeshift        # system restore point management
)

# DEVELOPMENT: All tools software for writing code/developing applications. 
PACKAGES_DEVELOPMENT=(
    tmux             # greatest tool ever?
    man-db           # manpages database
    python3          # scripting
    git              # why wouldn't you?
    build-essential  # GCC, make, libraries
    manpages-dev     # manual pages for Standard LibC
    cmake			 # build system generator
    gdb				 # debugger
    python3-pip      # package manager
)

# QUALITY-OF-LIFE: Software to make life easier sometimes.
PACKAGES_QOL=(
    file             # run against a file to see what file-type it is
    tree             # displays a filesystem tree given path 
    bat              # better cat tool with syntax highlighting
    xclip            # clipboard
    xsel             # clipboard tool
    ripgrep          # better grep
    cloc             # 'C'ount 'L'ines 'O'f 'C'ode
    fzf              # fuzzy find
    fd-find          # better find command
)

# FILES: Tooling designed to aid in file-related tasks.
PACKAGES_FILES=(
    unzip
    zip
    unrar-free
)

# NETWORKING: Great tools to diagnose network problems or just, have fun.
PACKAGES_NETWORKING=(
    iproute2         # provides command; 'ip'
    net-tools        # provides command; 'ifconfig', 'netstat'
    iputils-ping     # provides command; 'ping'
    traceroute       # diagnose network paths
    dnsutils         # provides command; 'dig', 'nslookup' (DNS testing)
    nmap             # network scanning/discovery
    tcpdump          # network traffic capturing/dumping tool
)


# These are required for these dotfile configuration/software to work.
PACKAGES_DOTFILES=(
    # SCREEN
    arandr
    brightnessctl
    light
    xbacklight

    # AUDIO
    pavucontrol
    pulseaudio
    pulseaudio-utils

    # TOOLS
    rofi             # app launcher
    nitrogen         # background handler
)

# I mean, they are widely pre-installed on distro's, but you don't need them.
PACKAGES_APPS=(
    gimp             # image editor
    inkscape         # vector image editor
    libreoffice      # free office suite
    qimgv            # image viewer
    obs              # recording software
)

# EXTRA: Not required at all, but they are interesting to look into.
PACKAGES_EXTRA=(
    pass             # cli password manager
)

is_installed() {
    dpkg -s "$1" &> /dev/null
}

filter_uninstalled() {
    local pkgs=("$@")
    local to_install=()

    echo -e "[$0] Package List: " >&2
    for pkg in "${pkgs[@]}"; do
        if is_installed "$pkg"; then
            # DISPLAY ONLY?
            echo -e " -> [\033[1;92m\033[0m] $pkg" >&2
        else
            echo -e " -> [\033[1;91m\033[0m] $pkg" >&2
            to_install+=("$pkg")
        fi
    done

    printf "%s\n" "${to_install[@]}"
}

prompt_group() {
    local name="$1"
    shift
    local pkgs=("$@")
    local preview_count=4

    if [ ${#pkgs[@]} -eq 0 ]; then
        echo -e "[$0] No packages defined for $name."
        return
    fi

    echo -e "\n[$0] $name Packages:"
    printf " -> %s\n" "${pkgs[@]:0:$preview_count}"

    if ((${#pkgs[@]} > preview_count)); then
        echo -e "    ... ${#pkgs[@]} more"
    fi

    echo -e ""
    read -p "    Install? [y/N] " choice
    if [[ "$choice" =~ ^[Yy]$ ]]; then
        PROMPT_SELECTED_PACKAGES=("${pkgs[@]}")
    else
        PROMPT_SELECTED_PACKAGES=()
    fi
}

# I NEED POWER
if [ "$(id -u)" -ne 0 ]; then
    echo "[$0] Script needs SUDO perms to install packages."
    echo "    SUDO $0"
    exit 1
fi

echo "Updating Package List..."
apt-get update -y

# adding basic required/neccesary packages
to_install=("${PACKAGES_SYSTEM[@]}")

# prompting & adding selected package groups
for group in SYSTEM DEVELOPMENT QOL FILES NETWORKING DOTFILES APPS EXTRA; do
    varname="PACKAGES_${group}"
    eval "group_pkgs=(\"\${${varname}[@]}\")"

    prompt_group "$group" "${group_pkgs[@]}"
    to_install+=("${PROMPT_SELECTED_PACKAGES[@]}")
done

# filter
echo ""
mapfile -t uninstalled_pkgs < <(filter_uninstalled "${to_install[@]}")
installed_count=$(( ${#to_install[@]} - ${#uninstalled_pkgs[@]} ))
uninstalled_count=${#uninstalled_pkgs[@]}
echo -e "\n[$0] Summary | Installed: $installed_count - Uninstalled $uninstalled_count"

# check if there are actually packages to install
if [ ${#uninstalled_pkgs[@]} -eq 0 ]; then
    echo -e "All packages already installed. Nothing to do."
    exit 0
fi

read -p "[$0] Do you wish to install ${#uninstalled_pkgs[@]} uninstalled packages? [y/N] " confirm
if [[ "$confirm" =~ ^[Nn]$ ]]; then
    echo "Aborting."
    exit 0
fi

echo -e "[$0] Starting the installation."
sudo apt install -y "${uninstalled_pkgs[@]}"

# complete
echo -e "\n[$0] \033[1;32mInstallation Complete, reboot to finalize.\033[0m"

