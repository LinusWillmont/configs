#!/bin/bash
# THIS INIT FILE NEEDS TO BE PLACED WHERE THE CONFIGS ARE STORED

HOME_DIR=/home/$USER
CONF_DIR=$(dirname "$(realpath "$0")")

function place_config() {
  local source_file=$1
  local dest_file=$2
  local dest_dir

  dest_dir=$(dirname "$dest_file")

  # Check if the source file exists
  if [ ! -e "$CONF_DIR/$source_file" ]; then
    echo "Error: Source file '$CONF_DIR/$source_file' does not exist."
    return 1
  fi

  # Create the parent directory if it does not exist
  mkdir -p "$dest_dir"
  if [ $? -ne 0 ]; then
    echo "Error: Could not create directory '$dest_dir'."
    return 1
  fi

  # Remove the destination file or link if it exists
  if [ -f "$dest_file" ] || [ -L "$dest_file" ]; then
    rm "$dest_file"
    if [ $? -ne 0 ]; then
      echo "Error: Could not remove existing file or link '$dest_file'."
      return 1
    fi
  elif [ -d "$dest_file" ]; then
    rm -r "$dest_file"
    if [ $? -ne 0 ]; then
      echo "Error: Could not remove existing directory '$dest_file'."
      return 1
    fi
  fi

  # Create a symbolic link
  ln -s "$CONF_DIR/$source_file" "$dest_file"
  if [ $? -ne 0 ]; then
    echo "Error: Could not create symlink from '$CONF_DIR/$source_file' to '$dest_file'."
    return 1
  fi

  echo "$source_file placed in -> $dest_file"
}

# Place configuration files
place_config "tmux/tmux.conf" "$HOME_DIR/.tmux.conf"
place_config "alacritty.yml" "$HOME_DIR/.config/alacritty/alacritty.yml"
place_config "nvim" "$HOME_DIR/.config/nvim"

exit 0
