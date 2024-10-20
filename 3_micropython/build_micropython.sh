#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_envars
export LOGFILE=$PWD/"build_micropython.log"
rm --force $LOGFILE

mkdir --parents $MICROPYTHON_PATH
pushd $MICROPYTHON_PATH/..
  echo "Cloning MicroPython"
  rm -fr $MICROPYTHON_PATH
  /usr/bin/time git clone $MICROPYTHON_URL \
    >> $LOGFILE 2>&1
  popd

pushd $HOME/Projects/micropython/ports/unix
  echo "Building mpy-cross"
  make -C ../../mpy-cross \
    >> $LOGFILE 2>&1
  echo "Fetching submodules"
  /usr/bin/time make submodules -j`nproc` \
    >> $LOGFILE 2>&1
  echo "Building executable"
  /usr/bin/time make -j`nproc` \
    >> $LOGFILE 2>&1
  echo "Copying micropython to $HOME/.local/bin"
  cp build-standard/micropython $HOME/.local/bin
  popd

echo "Finished"
