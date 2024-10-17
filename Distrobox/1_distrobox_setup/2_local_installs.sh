#! /usr/bin/env bash

set -e

echo "Setting base configuration files"
cp bashrc $HOME/.bashrc
cp bash_aliases $HOME/.bash_aliases
cp vimrc $HOME/.vimrc

echo "Creating $HOME/.local/bin and $HOME/bin"
mkdir --parents $HOME/.local/bin
mkdir --parents $HOME/bin
cp edit_me_then_run_4_git_config.sh $HOME/.local/bin

echo "Installing Meslo nerd fonts"
pushd /tmp

  echo "Downloading patched MesloLG Nerd fonts"
  rm --force --recursive Meslo*
  curl -sOL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
  mkdir Meslo
  cd Meslo
  unzip ../Meslo.zip

  echo "Copying to $HOME/.fonts"
  mkdir --parents $HOME/.fonts
  cp *.ttf $HOME/.fonts

  popd

# https://starship.rs/guide/#%F0%9F%9A%80-installation
echo "Installing Starship"
export BIN_DIR=$HOME/.local/bin
curl -sS https://starship.rs/install.sh | sh

echo "Adding Starship prompt to bash"
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

echo "Finished"
