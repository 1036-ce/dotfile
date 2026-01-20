#!/bin/bash

SCRIPT_DIR="$(dirname $(realpath $0))"
CONFIG_DIR=$HOME/.config

# deploy {target_dir} {file}
function deploy() {
  echo "$2 has been deployed at $1"
  rm "$1/$2"
  ln -s "$SCRIPT_DIR/$2" "$1/$2"
}

deploy $HOME ".bashrc"
deploy $HOME ".zshrc"
deploy $HOME ".vimrc"
deploy $HOME ".gdbinit"
deploy $HOME ".clang-format"
deploy $HOME ".gitconfig"
deploy $HOME ".tmux.conf"
deploy $HOME ".tmux"
deploy $HOME ".gdb"
deploy $HOME ".zsh"
deploy $CONFIG_DIR "nvim"
deploy $CONFIG_DIR "ranger"
deploy $CONFIG_DIR "ghostty"
