#!/bin/env sh

gein-extras() {
    read -ep "Install gein-extras? [Yes/No]: " Install
    if $Install | grep -iq "^n"; then exit; fi

    Wget="wget -q"
    Base_URL="https://raw.githubusercontent.com/jcmdln/gein/master"

    $Wget $Base_URL/etc/emacs/default.el   -O /etc/emacs/default.el
    $Wget $Base_URL/etc/profile            -O /etc/sudoers
    $Wget $Base_URL/etc/profile.d/alias.sh -O /etc/profile.d/alias
    $Wget $Base_URL/etc/sudoers            -O /etc/sudoers
    $Wget $Base_URL/etc/tmux.conf          -O /etc/tmux.conf
    $Wget $Base_URL/etc/vimrc              -O /etc/vimrc

    unset Wget
    unset Base_URL
}


gein-update() {
    emerge --sync
    emerge -av -uDN @system
    emerge -av -uDN @world
    emerge -av depclean
    revdep-rebuild -av
}
