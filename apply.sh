#!/bin/sh
pushd ~/.dotfiles
dconf dump / | dconf2nix > dconf.nix
sudo nixos-rebuild switch -v -I nixos-config=./configuration.nix
popd
