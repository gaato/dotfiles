#!/usr/bin/env zsh

# Function to create symbolic links
create_symlink() {
  src="$1"
  dest="$2"

  # Create parent directory if it doesn't exist
  parent_dir=$(dirname "$dest")
  mkdir -p "$parent_dir"

  # Confirm if the file already exists
  if [[ -e "$dest" ]]; then
    read "yn?$dest already exists. Overwrite? [y/N] "
    case $yn in
      [Yy]* ) ;;
      * ) return;;
    esac
  fi

  # Create the symbolic link
  ln -sf "$src" "$dest"
}

# List of files and directories to include
include=(".zshrc" ".vimrc" ".nanorc" ".config/nvim/init.lua" ".config/wezterm/wezterm.lua" ".config/doom/config.el" ".config/doom/init.el" ".config/doom/packages.el")

# Path to the dotfiles directory
dotfiles_dir="$PWD"

# Create symbolic links for specified files and directories in the dotfiles directory
for file in $include; do
  src="$dotfiles_dir/$file"
  dest="$HOME/$file"

  # Check if the source file exists
  if [[ ! -e "$src" ]]; then
    echo "$src does not exist. Skipping."
    continue
  fi

  create_symlink "$src" "$dest"
done
