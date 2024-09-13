#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles          # dotfiles directory
olddir=~/dotfiles_old   # old dotfiles backup directory
files="zshrc tmux.conf" # list of files/folders to symlink in homedir

config_dir=~/dotfiles/config        # config directory
config_olddir=~/dotfiles_old/config # old config backup directory
config_files="nvim sesh"            # list of directories to symlink in .config

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
  echo "Moving any existing dotfiles from ~ to $olddir"
  mv ~/.$file ~/dotfiles_old/
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

# create config_old in homedir
echo -n "Creating $config_olddir for backup of any existing config directories in ~/.config ..."
mkdir -p $config_olddir
echo "done"

# change to the config directory
echo -n "Changing to the $config_dir directory ..."
cd $config_dir
echo "done"

# move any existing config directories in ~/.config to config_old directory, then create symlinks from the ~/.config directory to any directories in the ~/dotfiles/config directory specified in $config_files
for config in $config_files; do
  echo "Moving any existing config directories from ~/.config to $config_olddir"
  mv ~/.config/$config ~/dotfiles_old/config/
  echo "Creating symlink to $config in .config directory."
  ln -s $config_dir/$config ~/.config/$config
done
