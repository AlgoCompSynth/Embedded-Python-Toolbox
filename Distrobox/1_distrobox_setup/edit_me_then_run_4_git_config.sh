#! /bin/bash

echo "Edit before running!"
echo "You at least need to set your name and email address."
echo "Sleeping 15 seconds"
sleep 15
git config --global advice.detached false
git config --global pull.rebase false
git config --global push.default simple
git config --global user.email ""
git config --global user.name ""
