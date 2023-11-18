#!/bin/bash

set -u

SCRIPT_DIR=$(dirname $(realpath $0))
cd "$SCRIPT_DIR"
for f in .??*; do
    [[ "$f" != ".gitconfig" && "$f" =~ ^\.git.* ]] && continue
    [[ "$f" == ".config" ]] && continue
    ln -snfv "$SCRIPT_DIR/$f" "$HOME/$f"
done

mkdir -p ~/.config
cd "$SCRIPT_DIR/.config"
for f in *; do
    rm -rf "$HOME/.config/$f"
    ln -sfv "$SCRIPT_DIR/.config/$f" "$HOME/.config/$f"
done

ln -sfv "$SCRIPT_DIR/rofi-power-menu/rofi-power-menu" ~/.config/i3/scripts/rofi-power-menu

if ! grep -q .bash_aliases ~/.bashrc; then
    echo Preparing .bashrc
    cat >> ~/.bashrc <<EOF

# Source aliases
if [[ -f ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi
EOF
fi
