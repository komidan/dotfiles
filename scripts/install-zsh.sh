#!/usr/bin/env bash

DOTFILES_ZSH="$HOME/dotfiles/configs/zsh/.zshrc"
TARGET_ZSH="$HOME/.zshrc"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

if ! command -v zsh &> /dev/null; then
    echo "Zsh Installed, and configuration found!"
    exit 1
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installed!"
    else
        echo "Install failed! :shrug:"
        exit 1
    fi
else
    echo "Zsh Already Installed!"
fi

if [ -e "$TARGET_ZSH" ] || [ -L "$TARGET_ZSH" ]; then
    echo "Removing existing .zshrc..."
    rm -f "$TARGET_ZSH"
fi

ln -s "$HOME/dotfiles/configs/zsh/.zshrc" "$HOME/.zshrc"
echo "Symlinked $DOTFILES_ZSH to $TARGET_ZSH"

mkdir -p "$ZSH_CUSTOM/themes/"
cp "$HOME/dotfiles/configs/zsh/custom.json" "$ZSH_CUSTOM/themes/"
