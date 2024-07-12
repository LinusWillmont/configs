#! /bin/bash
# THIS INIT FILE NEEDS TO BE PLACED WHERE THE CONFIGS ARE STORED

HOME_DIR=/home/$USER
CONF_DIR=$(dirname "$(realpath "$0")")

function place_config() {
  local source_file=$1
  local dest_file=$2

  if [ -f "$dest_file" ] || [ -L "$dest_file" ]; then
    rm "$dest_file"
  fi

  ln -s "$CONF_DIR/$source_file" "$dest_file"
  echo "$source_file placed in -> $dest_file"
}

place_config "tmux.conf" "$HOME/.tmux.conf"
place_config "alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

exit 0
