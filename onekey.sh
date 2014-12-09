#!/bin/sh

sudo apt-get update
sudo apt-get install -y git
git clone https://github.com/fangwentong/vimrc.git
cd vimrc
git checkout -t origin/master
sh -x install.sh
