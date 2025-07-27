#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles"
LOG_FILE="./log.txt"

log() {
    echo "[$(date '+%d-%b-%Y %H:%M:%S')] $1" | tee -a $LOG_FILE
}

if ! [ -d "$DOTFILES" ]; then
    log "(FAIL) dotfiles dir needs to be in '$HOME/"
    exit 1
fi

# <exe>:<source>:<dest>
DIRS=(
    "i3:$DOTFILES/i3:$HOME/.config/i3"
    "kitty:$DOTFILES/kitty:$HOME/.config/kitty"
    "nvim:$DOTFILES/nvim:$HOME/.config/nvim"
    "oh-my-posh:$DOTFILES/oh-my-posh:$HOME/.config/oh-my-posh"
    "polybar:$DOTFILES/polybar:$HOME/.config/polybar"
)

for conf in "${DIRS[@]}"; do
    IFS=":" read -r PROGRAM SRC DST <<< "$conf"

    if ! command -v "$PROGRAM" >/dev/null 2>&1; then
        log "program '$PROGRAM' not found or not installed"
        continue
    fi

    log "[ $PROGRAM ] "

    if [ -e "$DST" ] || [ -L "$DST" ]; then
        log "backing up (${DST}_backup)"
        mv $DST ${DST}_backup
    fi

    ln -s "$SRC" "$DST"
    log "linking $SRC -> $DST)"

    log ""
done
