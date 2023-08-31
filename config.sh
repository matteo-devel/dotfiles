#!/usr/bin/env bash
sudo xbps-install -u xbps

# nano for gh pr create TODO add mpv black
PKGS="helix redshift github-cli git translate-shell xclip clang clang-tools-extra pyright zellij python3-pip curl htop mmv nano go gopls cmake"
# in order to sync time on Void Linux
# refs: https://www.reddit.com/r/voidlinux/comments/z691x6/tutorial_how_to_sync_the_time_on_void_linux/
#       https://docs.voidlinux.org/config/services/index.html#enabling-services
# when live booting and clock is messed up, then "sudo SSL_NO_VERIFY_PEER=true xbps-install chrony"
# refs: https://www.reddit.com/r/voidlinux/comments/pyx9rj/xbpsinstall_su_returning_certificate_error/
PKGS="$PKGS chrony"
# install gnome-disks
PKGS="$PKGS gnome-disk-utility"
sudo xbps-install -Suy $PKGS

pip3 install cmake-format cmake-language-server # add to path '/home/matteo/.local/bin'

#enable sync-time service
sudo ln -s /etc/sv/chronyd /var/service && sudo sv up chronyd

# TODO install rust and rust-analyzer
# https://github.com/rust-lang/rust-analyzer/issues/14776

# install poetry and update it
# refs: https://python-poetry.org/docs/#installing-with-the-official-installer
#check if poetry is already installed TODO
# Add `export PATH="/home/matteo/.local/bin:$PATH"` to your shell configuration file.
curl -sSL https://install.python-poetry.org | python3 -
poetry self update

redshift -x && redshift -O 5800

sudo xbps-remove -ROov