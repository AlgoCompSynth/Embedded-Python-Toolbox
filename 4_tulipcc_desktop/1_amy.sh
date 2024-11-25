#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_envars
export LOGFILE=$PWD/1_amy.log
rm --force $LOGFILE

echo "Cloning fresh amy project repository"
mkdir --parents $AMY_PATH
pushd $AMY_PATH/..
  rm --force --recursive $AMY_PATH
  /usr/bin/time git clone $AMY_URL \
    >> $LOGFILE 2>&1
popd

echo "Creating and activating amy_venv"
rm --force --recursive $HOME/amy_venv
python3 -m venv $HOME/amy_venv --upgrade-deps
source $HOME/amy_venv/bin/activate
echo "Installing numpy"
pip3 install --upgrade numpy
echo "Building AMY"
pushd $AMY_PATH
  make test \
    >> $LOGFILE 2>&1
popd
echo "Deactivating amy_venv"
deactivate

echo "Finished"
