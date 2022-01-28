# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = {
    "background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/lino/.dotfiles/wallpaper.png";
      primary-color = "#ffffff";
      secondary-color = "#000000";
    };

    "calendar" = {
      show-weekdate = false;
    };

    "input-sources" = {
      per-window = false;
      sources = [ (mkTuple [ "xkb" "gb" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" "caps:swapescape" "keypad:atm" "compose:ralt" ];
    };

    "interface" = {
      cursor-theme = "Adwaita";
      document-font-name = "Rubik 11";
      enable-animations = true;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      font-name = "Rubik Medium 11";
      gtk-im-module = "gtk-im-context-simple";
      gtk-theme = "Nordic-darker";
      icon-theme = "Papirus-Dark";
      monospace-font-name = "Iosevka Medium 11";
      show-battery-percentage = false;
      toolkit-accessibility = false;
    };

    "notifications" = {
      application-children = [ "gnome-power-panel" "alacritty" "firefox" "org-gnome-nautilus" "element-desktop" "signal-desktop" "emacsclient" "gnome-control-center" "org-gnome-evolution-alarm-notify" "filezilla" "zotero-5-0-96-3" ];
      show-banners = false;
    };

    "notifications/application/alacritty" = {
      application-id = "Alacritty.desktop";
    };

    "notifications/application/ca-desrt-dconf-editor" = {
      application-id = "ca.desrt.dconf-editor.desktop";
    };

    "notifications/application/element-desktop" = {
      application-id = "element-desktop.desktop";
    };

    "notifications/application/emacsclient" = {
      application-id = "emacsclient.desktop";
    };

    "notifications/application/filezilla" = {
      application-id = "filezilla.desktop";
    };

    "notifications/application/firefox" = {
      application-id = "firefox.desktop";
    };

    "notifications/application/gnome-control-center" = {
      application-id = "gnome-control-center.desktop";
    };

    "notifications/application/gnome-network-panel" = {
      application-id = "gnome-network-panel.desktop";
    };

    "notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "notifications/application/org-gnome-evolution-alarm-notify" = {
      application-id = "org.gnome.Evolution-alarm-notify.desktop";
    };

    "notifications/application/org-gnome-music" = {
      application-id = "org.gnome.Music.desktop";
    };

    "notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "notifications/application/signal-desktop" = {
      application-id = "signal-desktop.desktop";
    };

    "notifications/application/zotero-5-0-96-3" = {
      application-id = "zotero-5.0.96.3.desktop";
    };

    "peripherals/keyboard" = {
      numlock-state = true;
    };

    "peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "privacy" = {
      disable-microphone = false;
    };

    "screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/lino/.dotfiles/wallpaper.png";
      primary-color = "#ffffff";
      secondary-color = "#000000";
    };

    "search-providers" = {
      disabled = [ "org.gnome.Contacts.desktop" ];
      sort-order = [ "org.gnome.Documents.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Calculator.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.clocks.desktop" "org.gnome.Calendar.desktop" "org.gnome.Weather.desktop" "org.gnome.Contacts.desktop" ];
    };

    "sound" = {
      event-sounds = true;
      theme-name = "__custom";
    };

    "wm/keybindings" = {
      activate-window-menu = [];
      close = [ "<Super>q" ];
      cycle-windows = [];
      cycle-windows-backward = [];
      move-to-workspace-1 = [ "<Shift><Super>exclam" ];
      move-to-workspace-2 = [ "<Shift><Super>quotedbl" ];
      move-to-workspace-3 = [ "<Shift><Super>sterling" ];
      move-to-workspace-4 = [ "<Shift><Super>dollar" ];
      move-to-workspace-last = [];
      move-to-workspace-left = [ "<Shift><Super>a" ];
      move-to-workspace-right = [ "<Shift><Super>d" ];
      switch-input-source = [];
      switch-input-source-backward = [];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-left = [ "<Super>a" ];
      switch-to-workspace-right = [ "<Super>d" ];
      toggle-fullscreen = [ "<Alt>f" ];
    };

    "wm/preferences" = {
      auto-raise = true;
      button-layout = "appmenu:minimize,maximize,close";
      focus-mode = "sloppy";
      titlebar-font = "Rubik Medium 11";
      workspace-names = [ "Communication" "Web" ];
    };

  };
}
