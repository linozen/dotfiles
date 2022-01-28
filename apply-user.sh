#!/bin/sh
pushd /home/lino/.dotfiles

nix build .#homeManagerConfigurations.lino-$(hostname).activationPackage
./result/activate

popd
