#!/bin/bash

set -eu

SCRIPT_DIR=$(dirname $(realpath $0))
cd "${SCRIPT_DIR}"
for f in .??*; do
    [[ "$f" != ".gitconfig" && "$f" =~ ^\.git.* ]] && continue
    [[ "$f" == ".config" ]] && continue
    ln -snfv "${SCRIPT_DIR}/${f}" "${HOME}/${f}"
done

mkdir -p ~/.config
cd "${SCRIPT_DIR}/.config"
for f in *; do
    rm -rf "${HOME}/.config/$f"
    ln -sfv "${SCRIPT_DIR}/.config/${f}" "${HOME}/.config/${f}"
done

ln -sfv "${SCRIPT_DIR}/submodules/rofi-power-menu/rofi-power-menu" ~/.config/i3/scripts/rofi-power-menu

mkdir -p ~/.local/bin
cd "${SCRIPT_DIR}/scripts"
for f in *; do
    ln -sfv "${SCRIPT_DIR}/scripts/${f}" "${HOME}/.local/bin/${f}"
done
