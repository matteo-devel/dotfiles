#!/usr/bin/env bash
sudo xbps-install -u xbps

PKGS="helix redshift github-cli git translate-shell xclip clang clang-tools-extra pyright zellij python3-pip curl htop"
# in order to sync time on Void Linux
# refs: https://www.reddit.com/r/voidlinux/comments/z691x6/tutorial_how_to_sync_the_time_on_void_linux/
#       https://docs.voidlinux.org/config/services/index.html#enabling-services
# when live booting and clock is messed up, then "sudo SSL_NO_VERIFY_PEER=true xbps-install chrony"
# refs: https://www.reddit.com/r/voidlinux/comments/pyx9rj/xbpsinstall_su_returning_certificate_error/
PKGS="$PKGS chrony"
# install gnome-disks
PKGS="$PKGS gnome-disk-utility"
sudo xbps-install -Suy $PKGS

#enable sync-time service
sudo ln -s /etc/sv/chronyd /var/service && sudo sv up chronyd

# install poetry and update it
# refs: https://python-poetry.org/docs/#installing-with-the-official-installer
#check if poetry is already installed TODO
# Add `export PATH="/home/matteo/.local/bin:$PATH"` to your shell configuration file.
curl -sSL https://install.python-poetry.org | python3 -
poetry self update

redshift -x && redshift -O 5800

sudo xbps-remove -ROov