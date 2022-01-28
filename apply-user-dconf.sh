#!/bin/sh
pushd /home/lino/.dotfiles

dconf dump /org/gnome/desktop/ | dconf2nix > ./users/modules/dconf/desktop.nix
dconf dump /org/gnome/shell/keybindings/ | dconf2nix > ./users/modules/dconf/shell-keybindings.nix
dconf dump /org/gnome/shell/extnesions/ | dconf2nix > ./users/modules/dconf/extensions.nix
dconf dump /org/gnome/shell/extensions/clipboard-indicator/ | dconf2nix > ./users/modules/dconf/ext-clipboard-indicator.nix
dconf dump /org/gnome/shell/extensions/floating-dock/ | dconf2nix > ./users/modules/dconf/ext-floating-dock.nix
dconf dump /org/gnome/shell/extensions/gnome-ui-tune/ | dconf2nix > ./users/modules/dconf/ext-gnome-ui-tune.nix
dconf dump /org/gnome/shell/extensions/just-perfection/ | dconf2nix > ./users/modules/dconf/ext-just-perfection.nix
dconf dump /org/gnome/shell/extensions/mullvadindicator/ | dconf2nix > ./users/modules/dconf/ext-just-perfection.nix
dconf dump /org/gnome/shell/extensions/tiling-assistant/ | dconf2nix > ./users/modules/dconf/ext-tiling-assistant.nix

nix build .#homeManagerConfigurations.lino-$(hostname).activationPackage
./result/activate

popd
