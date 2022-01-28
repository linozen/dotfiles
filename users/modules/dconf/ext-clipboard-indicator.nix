# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = {
    "" = {
      clear-history = [];
      disable-down-arrow = true;
      display-mode = 0;
      history-size = 50;
      next-entry = [];
      prev-entry = [];
      refresh-interval = 1000;
      toggle-menu = [];
    };

  };
}
