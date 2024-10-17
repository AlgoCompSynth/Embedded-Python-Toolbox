#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_envars

pushd /tmp

  echo ""
  echo "Downloading Arm cross-compiler tarball"
  rm -f $ARM_COMPILER_TARBALL
  /usr/bin/time curl -sOL $ARM_COMPILER_URL

  echo "Installing"
  mkdir --parents $ARM_COMPILER_PATH
  /usr/bin/time tar --extract \
    --file $ARM_COMPILER_TARBALL \
    --strip-components=1 \
    --directory=$ARM_COMPILER_PATH \
    > arm-extract.log 2>&1
  $ARM_COMPILER_PATH/bin/arm-none-eabi-gcc --version
  echo "Install complete"

  echo ""
  echo "Downloading RISC-V cross-compiler tarball"
  rm -f $RISCV_COMPILER_TARBALL
  /usr/bin/time curl -sOL $RISCV_COMPILER_URL

  echo "Installing"
  mkdir --parents $RISCV_COMPILER_PATH
  /usr/bin/time tar --extract \
    --file $RISCV_COMPILER_TARBALL \
    --strip-components=1 \
    --directory=$RISCV_COMPILER_PATH \
    > risc-v-extract.log 2>&1
  $RISCV_COMPILER_PATH/bin/riscv32-corev-elf-gcc --version
  echo "Install complete"

  popd

echo "Generating compiler 'man' pages"
mandb $HOME/.local/share/man

echo "Finished"
