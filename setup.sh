#!/bin/sh
# very minimal setup

usage() {
  echo "$(basename $0) arch|debian"
}

[ $# -eq 1 ] || { usage; exit 1; }

PACKAGES="stow vimpager tmux i3-wm git"

case $1 in
  arch)
    PM="pacman -S"
    PACKAGES+=" yaourt"
    ;;
  debian)
    PM="apt-get"
    ;;
  *)
    usage
    exit 1
    ;;
esac

$PM $PACKAGES
if [ "$PM" == "pacman -S" ]; then
  yaourt pam_ssh
fi

mkdir ~/bin
cd
git clone https://github.com/windowsrefund/dotfiles
cd dotfiles

for i in X i3 termite tmux; do
  stow $i
done


