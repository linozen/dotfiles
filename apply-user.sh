#!/bin/sh
pushd /home/lino/.dotfiles
dconf dump / | dconf2nix > ./users/lino/dconf/$(hostname).nix
home-manager switch -f ./users/lino/home.nix
popd
