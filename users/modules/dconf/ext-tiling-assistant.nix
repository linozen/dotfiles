# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = {
    "org/gnome/shell/extensions/tiling-assistant" = {
      activate-layout0 = [];
      activate-layout1 = [];
      activate-layout2 = [];
      activate-layout3 = [];
      auto-tile = [ "<Alt>t" ];
      change-favorite-layout = [];
      changelog-version = 27;
      debugging-free-rects = [ "<Alt>v" ];
      debugging-show-tiled-rects = [ "<Alt>m" ];
      default-move-mode = "Edge Tiling";
      dynamic-keybinding-behaviour = "Tiling State";
      enable-advanced-experimental-features = false;
      enable-raise-tile-group = false;
      enable-tiling-popup = false;
      import-layout-examples = false;
      maximize-with-gap = false;
      move-favorite-layout-mod = "Alt";
      move-split-tiles-mod = "Alt";
      screen-gap = 22;
      search-popup-layout = [];
      tile-bottom-half = [ "<Alt>s" ];
      tile-bottomleft-quarter = [ "<Alt>z" ];
      tile-bottomright-quarter = [ "<Alt>c" ];
      tile-edit-mode = [ "<Alt>space" ];
      tile-left-half = [ "<Alt>a" ];
      tile-maximize = [ "<Control><Alt>d" ];
      tile-right-half = [ "<Alt>d" ];
      tile-top-half = [ "<Alt>w" ];
      tile-topleft-quarter = [ "<Alt>q" ];
      tile-topright-quarter = [ "<Alt>e" ];
      tiling-popup-all-workspace = true;
      toggle-tiling-popup = [];
      window-gap = 20;
    };

  };
}
