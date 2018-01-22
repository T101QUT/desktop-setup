#!/bin/bash
# Place this file in the same directory as the cloned repo
#git clone https://github.com/vinceliuice/grub2-themes.git

# Install vimix theme for fedora efi install
ROOT_UID=0
DIR=$(dirname ${BASH_SOURCE[0]})
THEME_SOURCE_DIR=$DIR/grub2-themes/grub-themes-vimix/Vimix

GRUB_FILE=/etc/default/grub
GRUB_THEMES_DIR=/boot/grub2/themes
GRUB_CFG=/boot/efi/EFI/fedora/grub.cfg
GRUB_THEME_TXT=Vimix/theme.txt

install_grub_theme() {
    # Copy theme files to grub themes directory
    cp -a ${THEME_SOURCE_DIR} ${GRUB_THEMES_DIR}

    # Remove grub theme setting if any were previously set
    sed -i '/GRUB_THEME=/d' ${GRUB_FILE}

    # Add grub theme to grub file
    echo "GRUB_THEME=\"${GRUB_THEMES_DIR}/${GRUB_THEME_TXT}\"" >> ${GRUB_FILE}

    # Update grub
    grub2-mkconfig -o ${GRUB_CFG}
}

if [ "$UID" -eq "$ROOT_UID" ]; then
    install_grub_theme
else
  echo -e "/n Please run this script by root..."
  notify-send "Please run this script by root..." -i notification
fi