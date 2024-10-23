#! /usr/bin/env bash

set -e

echo "Updating package cache"
/usr/bin/time sudo apt-get update

echo "Upgrading packages"
/usr/bin/time sudo apt-get upgrade --assume-yes

echo "Restoring missing 'man' pages"
sudo touch /etc/dpkg/dpkg.cfg.d/excludes
echo "Y" | /usr/bin/time sudo unminimize
