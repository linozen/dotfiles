#!/bin/sh
pushd /home/lino/.dotfiles
dconf dump / | dconf2nix > ./users/lino/dconf/$(hostname).nix
nix build .#homeManagerConfigurations.lino-$(hostname).activationPackage
./result/activate
popd
