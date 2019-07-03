#!/usr/bin/env bash

SCRIPT=$(readlink -f "$0")
DOTFILES_DIR=$(dirname "$SCRIPT")

function link() {
  LINK="$HOME/$1"
  LINK_BASEDIR=$(dirname "$LINK")
  mkdir -p "$LINK_BASEDIR"
  ln -s "$DOTFILES_DIR/$1" "$LINK"
}

link .config/git/config
link .config/mpv/mpv.conf
link .config/nvim/init.vim
link .config/vifm/vifmrc
link .ctags
link .ssh/config
link .xmobarrc
link .xmobarrc.left
link .xmobarrc.right
link .xmonad
