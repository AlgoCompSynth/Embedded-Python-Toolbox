#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_envars
export LOGFILE=$PWD/"build_pico_ice_micropython.log"
rm --force $LOGFILE

mkdir --parents $PICO_ICE_MICROPYTHON_PATH
pushd $PICO_ICE_MICROPYTHON_PATH/..
  echo "Cloning MicroPython"
  rm -fr $PICO_ICE_MICROPYTHON_PATH
  /usr/bin/time git clone $PICO_ICE_MICROPYTHON_URL \
    >> $LOGFILE 2>&1
popd

pushd $PICO_ICE_MICROPYTHON_PATH

  echo "Fetching submodulers"
  git submodule update --init lib/micropython \
    >> $LOGFILE 2>&1
  git submodule update --init lib/pico-ice-mpy-module \
    >> $LOGFILE 2>&1
  cd lib/pico-ice-mpy-module
  git submodule update --init pico-ice-sdk \
    >> $LOGFILE 2>&1
  cd ../..

  echo "Building mpy-cross"
  make -C lib/micropython/mpy-cross --jobs=`nproc` \
    >> $LOGFILE 2>&1

  echo "Building submodules"
  make -C lib/micropython/ports/rp2 submodules \
    >> $LOGFILE 2>&1

  echo "Configuring MicroPython"
  cd boards/PICO_ICE
  mkdir build && cd build
  cmake -DPICO_BOARD=pico2_ice .. \
    >> $LOGFILE 2>&1

  echo "Building MicroPython"
  make --jobs=`nproc` \
    >> $LOGFILE 2>&1

popd

echo "Finished"
