#!/usr/bin/env bash
sudo xbps-install -u xbps

PKGS="helix redshift github-cli git translate-shell xclip clang clang-tools-extra pyright zellij"
# in order to sync time on Void Linux
# refs: https://www.reddit.com/r/voidlinux/comments/z691x6/tutorial_how_to_sync_the_time_on_void_linux/
#       https://docs.voidlinux.org/config/services/index.html#enabling-services
# when live booting and clock is messed up, then "sudo SSL_NO_VERIFY_PEER=true xbps-install chrony"
# refs: https://www.reddit.com/r/voidlinux/comments/pyx9rj/xbpsinstall_su_returning_certificate_error/
PKGS="$PKGS chrony"
# install poetry and pip
PKGS="$PKGS python3-poetry-core python3-pip"
# install gnome-disks
PKGS="$PKGS gnome-disk-utility"
sudo xbps-install -Suy $PKGS

#enable sync-time service
sudo ln -s /etc/sv/chronyd /var/service && sudo sv up chronyd

redshift -x && redshift -O 5800

sudo xbps-remove -ROov