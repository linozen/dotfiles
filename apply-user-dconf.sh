#!/bin/sh
pushd /home/lino/.dotfiles

# TODO Make this more elegant
dconf dump /org/gnome/desktop/ | \
    dconf2nix -r /org/gnome/desktop > \
    ./users/modules/dconf/desktop.nix

dconf dump /org/gnome/shell/extensions/clipboard-indicator/ | \
    dconf2nix -r /org/gnome/shell/extensions/clipboard-indicator > \
    ./users/modules/dconf/ext-clipboard-indicator.nix

dconf dump /org/gnome/shell/extensions/dash-to-dock/ | \
    dconf2nix -r /org/gnome/shell/extensions/dash-to-dock > \
    ./users/modules/dconf/ext-dash-to-dock.nix

dconf dump /org/gnome/shell/extensions/gnome-ui-tune/ | \
    dconf2nix -r /org/gnome/shell/extensions/gnome-ui-tune \
    > ./users/modules/dconf/ext-gnome-ui-tune.nix

dconf dump /org/gnome/shell/extensions/just-perfection/ | \
    dconf2nix -r /org/gnome/shell/extensions/just-perfection \
    > ./users/modules/dconf/ext-just-perfection.nix

dconf dump /org/gnome/shell/extensions/tiling-assistant/ | \
    dconf2nix -r /org/gnome/shell/extensions/tiling-assistant \
    > ./users/modules/dconf/ext-tiling-assistant.nix

nix build .#homeManagerConfigurations.lino-$(hostname).activationPackage
./result/activate

popd
