#! /usr/bin/env bash

set -e

./unminimize.sh

echo "Defining LOGFILE"
export LOGFILE=$PWD/1_base_packages.log
rm --force $LOGFILE

echo "Installing base packages"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes \
  apt-file \
  build-essential \
  cmake \
  curl \
  file \
  gettext \
  git \
  git-lfs \
  lsb-release \
  lynx \
  man-db \
  minicom \
  plocate \
  python3-dev \
  python3-pip \
  python3-setuptools \
  python3-venv \
  python3-wheel \
  screen \
  speedtest-cli \
  tmux \
  tree \
  usbutils \
  wget \
  >> $LOGFILE 2>&1

echo "Finished"
