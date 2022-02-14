# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = {
    "org/gnome/shell/extensions/just-perfection" = {
      accessibility-menu = false;
      activities-button = false;
      animation = 3;
      app-menu = false;
      app-menu-icon = true;
      background-menu = false;
      clock-menu = true;
      dash = true;
      dash-icon-size = 0;
      double-super-to-appgrid = false;
      gesture = true;
      hot-corner = false;
      keyboard-layout = false;
      osd = true;
      panel = true;
      panel-arrow = true;
      panel-corner-size = 0;
      panel-in-overview = true;
      panel-size = 0;
      ripple-box = true;
      search = true;
      show-apps-button = false;
      startup-status = 1;
      theme = false;
      window-demands-attention-focus = true;
      window-picker-icon = true;
      window-preview-caption = true;
      workspace = true;
      workspace-background-corner-size = 0;
      workspace-popup = true;
      workspace-switcher-should-show = false;
      workspaces-in-app-grid = true;
    };

  };
}
