#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_envars
export LOGFILE=$PWD/"build_circuit_python.log"
rm --force $LOGFILE

mkdir --parents $HOME/Projects
pushd $HOME/Projects

  echo "Cloning CircuitPython"
  rm -fr circuitpython
  /usr/bin/time git clone https://github.com/adafruit/circuitpython.git \
    >> $LOGFILE 2>&1

  popd

pushd $HOME/Projects/circuitpython

  echo "Fetching git submodules"
  /usr/bin/time make fetch-all-submodules \
    >> $LOGFILE 2>&1

  echo "Creating / activating fresh virtual environment $CIRCUITPYTHON_VENV/"
  rm --force --recursive $CIRCUITPYTHON_VENV/
  python3 -m venv $CIRCUITPYTHON_VENV/ --upgrade-deps
  source $CIRCUITPYTHON_VENV//bin/activate

    echo "Installing Python requirements"
    /usr/bin/time pip3 install --upgrade -r requirements-dev.txt \
      >> $LOGFILE 2>&1
    /usr/bin/time pip3 install --upgrade -r requirements-doc.txt \
      >> $LOGFILE 2>&1

    echo "Building mpy-cross"
    /usr/bin/time make -C mpy-cross \
      >> $LOGFILE 2>&1

    pushd $HOME/Projects/circuitpython/ports/unix

      echo "Building Unix port"
      /usr/bin/time make submodules -j`nproc` \
        >> $LOGFILE 2>&1
      /usr/bin/time make -j`nproc` \
        >> $LOGFILE 2>&1
      cp build-standard/micropython $HOME/.local/bin

      popd

    pushd $HOME/Projects/circuitpython

      echo "Building HTML manual"
      set +e
      $(/usr/bin/time make html > make_html.log 2>&1) \
        > /dev/null 2>&1
      set +e

      popd

    echo "Deactivating virtual environment"
    deactivate

  popd

echo "Finished"
