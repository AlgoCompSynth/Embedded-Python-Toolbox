#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_envars
export LOGFILE=$PWD/1_tulipcc_desktop.log
rm --force $LOGFILE

echo "Cloning fresh tulipcc project repository"
mkdir --parents $TULIPCC_PATH
pushd $TULIPCC_PATH/..
  rm --force --recursive $TULIPCC_PATH
  /usr/bin/time git clone $TULIPCC_URL \
    >> $LOGFILE 2>&1
  popd

echo "Building Tulip CC Desktop"
pushd $TULIPCC_PATH
  cd tulip/linux
  ./build.sh \
    >> $LOGFILE 2>&1

  echo "Copying 'tulip' executable to $HOME/.local/bin"
  cp ./dev/tulip $HOME/.local/bin
  popd

echo "To start the Tulip CC Desktop, enter 'tulip' on the terminal."

echo "Finished"
