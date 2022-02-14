# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = {
    "org/gnome/shell/extensions/dash-to-dock" = {
      animation-time = 0.1;
      apply-custom-theme = false;
      autohide-in-fullscreen = true;
      background-opacity = 0.8;
      border-radius = 20;
      click-action = "skip";
      custom-background-color = false;
      custom-theme-shrink = true;
      dash-max-icon-size = 48;
      dock-position = "BOTTOM";
      extend-height = false;
      floating-margin = 3;
      height-fraction = 0.9;
      hide-delay = 0.1;
      hot-keys = false;
      hotkeys-overlay = true;
      hotkeys-show-dock = false;
      intellihide-mode = "ALL_WINDOWS";
      isolate-locations = true;
      multi-monitor = true;
      pressure-threshold = 0.0;
      preview-size-scale = 0.3;
      require-pressure-to-show = false;
      running-indicator-style = "DEFAULT";
      scroll-action = "cycle-windows";
      shortcut = [ "<Super>q" ];
      shortcut-text = "<Super>q";
      shortcut-timeout = 2.0;
      show-favorites = true;
      show-mounts = false;
      show-running = true;
      show-show-apps-button = false;
      show-trash = false;
      show-windows-preview = false;
    };

  };
}
