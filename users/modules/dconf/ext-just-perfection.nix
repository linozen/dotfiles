# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = {
    "org/gnome/shell/extensions/just-perfection" = {
      activities-button = false;
      app-menu = false;
      panel = true;
    };

  };
}
