#!/bin/bash
sudo rm -rf /usr/local/bin/terraform

. /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh
cp -p $GITHUB_WORKSPACE/.tool-versions $HOME/
for i in `awk '{print $1}' ~/.tool-versions`
do
  asdf plugin add $i
done
asdf install
asdf list
