#!/bin/sh
pushd /home/lino/.dotfiles
sudo nixos-rebuild switch --flake .#
popd
