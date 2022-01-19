#!/bin/sh
pushd /home/lino/.dotfiles
sudo nixos-rebuild switch -v -I nixos-config=./configuration.nix
popd
