#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles/configs"
LOG_FILE="./log.txt"

if ! [ -d "$DOTFILES" ]; then
    log "dotfiles dir needs to be in '$HOME/'"
    exit 1
fi

# <executable name>:<source of config>:<where to symlink to>
DIRS=(
    "i3:$DOTFILES/i3:$HOME/.config/i3"
    "kitty:$DOTFILES/kitty:$HOME/.config/kitty"
    "nvim:$DOTFILES/nvim:$HOME/.config/nvim"
    "oh-my-posh:$DOTFILES/oh-my-posh:$HOME/.config/oh-my-posh"
    "polybar:$DOTFILES/polybar:$HOME/.config/polybar"
    "tmux:$DOTFILES/tmux:$HOME/.config/tmux"
)

for conf in "${DIRS[@]}"; do
    IFS=: read -r PROGRAM SRC DST <<< "$conf"

    echo -e "[$PROGRAM]"
    if ! command -v "$PROGRAM" >/dev/null 2>&1; then
        echo "  Not found/installed. Skipping."
        continue
    fi

    if [ -L "$DST" ]; then
        echo "  Removing old symlink."
        rm "$DST"
    elif [ -e "$DST" ]; then
        echo "  Creating backup before linking."
        mv "$DST" "$BACKUP"
    fi

    # link
    ln -s "$SRC" "$DST"
    echo "  Linking dotfiles folder."
done
