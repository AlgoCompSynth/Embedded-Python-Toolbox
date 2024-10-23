#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/1_global_installs.log
rm --force $LOGFILE

echo "Adding git PPA"
/usr/bin/time ./add_git_ppa.sh \
  >> $LOGFILE 2>&1

echo "Restoring missing man pages"
/usr/bin/time ./unminimize.sh \
  >> $LOGFILE 2>&1

echo "Installing base packages"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes \
  alsa-utils \
  apt-file \
  bash-completion \
  build-essential \
  cmake \
  curl \
  file \
  gettext \
  git \
  git-lfs \
  libffi-dev \
  libsdl2-dev \
  lsb-release \
  lynx \
  man-db \
  minicom \
  ninja-build \
  pkg-config \
  plocate \
  python-is-python3 \
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
