#!/bin/bash

CUR_DIR=`pwd`
CONFIG_DIR=$HOME/.config

# echo $CUR_DIR
ln -s $CUR_DIR/.bashrc       $HOME/.bashrc
ln -s $CUR_DIR/.zshrc        $HOME/.zshrc
ln -s $CUR_DIR/.vimrc        $HOME/.vimrc
ln -s $CUR_DIR/.gdbinit      $HOME/.gdbinit
ln -s $CUR_DIR/.clang-format $HOME/.clang-format
ln -s $CUR_DIR/.gitconfig    $HOME/.gitconfig
ln -s $CUR_DIR/.tmux.conf    $HOME/.tmux.conf
ln -s $CUR_DIR/.tmux         $HOME/.tmux
ln -s $CUR_DIR/.gdb          $HOME/.gdb
ln -s $CUR_DIR/.zsh          $HOME/.zsh

ln -s $CUR_DIR/nvim			 $CONFIG_DIR/nvim
