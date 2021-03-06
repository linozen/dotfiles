# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = {
    "apps/seahorse/listing" = {
      item-filter = "trusted";
      keyrings-selected = [ "gnupg://" ];
    };

    "apps/seahorse/windows/key-manager" = {
      height = 767;
      width = 1546;
    };

    "ca/desrt/dconf-editor" = {
      saved-pathbar-path = "";
      saved-view = "/org/gnome/";
      window-height = 500;
      window-is-maximized = true;
      window-width = 540;
    };

    "org/gnome/Fractal" = {
      main-window-state-height = 644;
      main-window-state-maximized = false;
      main-window-state-width = 1493;
      main-window-state-x = 240;
      main-window-state-y = 219;
    };

    "org/gnome/GWeather" = {
      temperature-unit = "centigrade";
    };

    "org/gnome/Weather" = {
      locations = "[<(uint32 2, <('Berlin-Schoenefeld', 'EDDB', false, [(0.91426163401859872, 0.23591034304566436)], @a(dd) [])>)>]";
    };

    "org/gnome/baobab/ui" = {
      window-size = mkTuple [ 960 600 ];
      window-state = 87168;
    };

    "org/gnome/calendar" = {
      active-view = "week";
      window-maximized = true;
      window-position = mkTuple [ 0 0 ];
      window-size = mkTuple [ 1920 1080 ];
    };

    "org/gnome/clocks/state/window" = {
      panel-id = "world";
      size = mkTuple [ 758 690 ];
      state = 87168;
    };

    "org/gnome/control-center" = {
      last-panel = "keyboard";
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/lino/.dotfiles/wallpaper.png";
      primary-color = "#ffffff";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = false;
    };

    "org/gnome/desktop/input-sources" = {
      per-window = false;
      sources = [ (mkTuple [ "xkb" "gb" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" "caps:swapescape" "keypad:atm" "compose:ralt" ];
    };

    "org/gnome/desktop/interface" = {
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
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "gnome-power-panel" "alacritty" "firefox" "org-gnome-nautilus" "element-desktop" "signal-desktop" "emacsclient" "gnome-control-center" "org-gnome-evolution-alarm-notify" ];
      show-banners = false;
    };

    "org/gnome/desktop/notifications/application/alacritty" = {
      application-id = "Alacritty.desktop";
    };

    "org/gnome/desktop/notifications/application/element-desktop" = {
      application-id = "element-desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/emacsclient" = {
      application-id = "emacsclient.desktop";
    };

    "org/gnome/desktop/notifications/application/firefox" = {
      application-id = "firefox.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-control-center" = {
      application-id = "gnome-control-center.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-network-panel" = {
      application-id = "gnome-network-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-evolution-alarm-notify" = {
      application-id = "org.gnome.Evolution-alarm-notify.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/notifications/application/signal-desktop" = {
      application-id = "signal-desktop.desktop";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      disable-microphone = false;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/lino/.dotfiles/wallpaper.png";
      primary-color = "#ffffff";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/search-providers" = {
      disabled = [ "org.gnome.Contacts.desktop" ];
      sort-order = [ "org.gnome.Documents.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Calculator.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.clocks.desktop" "org.gnome.Calendar.desktop" "org.gnome.Weather.desktop" "org.gnome.Contacts.desktop" ];
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      switch-input-source = [];
      switch-input-source-backward = [];
      toggle-fullscreen = [ "<Alt>f" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      titlebar-font = "Rubik Medium 11";
      workspace-names = [ "Communication" "Web" ];
    };

    "org/gnome/eog/view" = {
      background-color = "rgb(0,0,0)";
      use-background-color = true;
    };

    "org/gnome/epiphany/state" = {
      is-maximized = false;
      window-position = mkTuple [ (-1) (-1) ];
      window-size = mkTuple [ 1024 768 ];
    };

    "org/gnome/evince/default" = {
      window-ratio = mkTuple [ 1.006524 0.704501 ];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
      network-monitor-gio-name = "";
    };

    "org/gnome/evolution-data-server/calendar" = {
      notify-window-height = 150;
      notify-window-paned-position = 48;
      notify-window-width = 521;
      notify-window-x = 0;
      notify-window-y = 0;
      reminders-past = [];
    };

    "org/gnome/evolution" = {
      default-calendar = "b48445c2d2e56b9e16d9776067f24730aa0e4d97";
    };

    "org/gnome/file-roller/dialogs/extract" = {
      recreate-folders = true;
      skip-newer = false;
    };

    "org/gnome/file-roller/listing" = {
      list-mode = "as-folder";
      name-column-width = 250;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 200;
      window-height = 480;
      window-width = 1038;
    };

    "org/gnome/gnome-system-monitor" = {
      current-tab = "resources";
      maximized = false;
      network-total-in-bits = false;
      show-dependencies = false;
      show-whose-processes = "user";
      window-state = mkTuple [ 1230 656 ];
    };

    "org/gnome/gnome-system-monitor/disktreenew" = {
      col-6-visible = true;
      col-6-width = 0;
    };

    "org/gnome/gnome-system-monitor/proctree" = {
      columns-order = [ 0 1 2 3 4 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 ];
      sort-col = 15;
      sort-order = 0;
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = false;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/nautilus/list-view" = {
      default-zoom-level = "small";
      use-tree-view = true;
    };

    "org/gnome/nautilus/preferences" = {
      click-policy = "double";
      default-folder-viewer = "list-view";
      search-filter-time-type = "last_modified";
      search-view = "list-view";
      show-create-link = true;
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 890 550 ];
      maximized = false;
      sidebar-width = 236;
    };

    "org/gnome/nm-applet/eap/c7b4fb75-644b-41d9-bb7a-df960ccd59e2" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-schedule-from = 18.0;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      help = [];
      home = [ "<Super>f" ];
      www = [ "<Super>b" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>space";
      command = "alacritty";
      name = "Lauch Terminal";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = true;
    };

    "org/gnome/shell" = {
      command-history = [ "r" ];
      disable-user-extensions = false;
      disabled-extensions = [ "native-window-placement@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "just-perfection-desktop@just-perfection" "dash-to-dock@micxgx.gmail.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "system-monitor@paradoxxx.zero.gmail.com" ];
      enabled-extensions = [ "x11gestures@joseexposito.github.io" "user-theme@gnome-shell-extensions.gcampax.github.com" "tiling-assistant@leleat-on-github" "mullvadindicator@pobega.github.com" "hidetopbar@mathieu.bidon.ca" "gnome-ui-tune@itstime.tech" "floating-dock@nandoferreira_prof@hotmail.com" "clipboard-indicator@tudmotu.com" ];
      favorite-apps = [ "emacsclient.desktop" "zotero-5.0.96.3.desktop" "firefox.desktop" "Alacritty.desktop" "element-desktop.desktop" "bitwarden.desktop" "org.gnome.Nautilus.desktop" "org.gnome.tweaks.desktop" "org.gnome.Calendar.desktop" ];
      had-bluetooth-devices-setup = true;
      remember-mount-password = false;
      welcome-dialog-last-shown-version = "41.1";
    };

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [];
    };

    "org/gnome/shell/extensions/clipboard-indicator" = {
      clear-history = [];
      disable-down-arrow = true;
      display-mode = 0;
      history-size = 50;
      next-entry = [];
      prev-entry = [];
      refresh-interval = 1000;
      toggle-menu = [ "<Alt>c" ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      animation-time = 0.1;
      apply-custom-theme = false;
      autohide-in-fullscreen = true;
      background-opacity = 0.8;
      border-radius = 20;
      custom-background-color = false;
      custom-theme-shrink = true;
      dash-max-icon-size = 48;
      dock-position = "BOTTOM";
      extend-height = false;
      floating-margin = 3;
      height-fraction = 0.9;
      hide-delay = 0.1;
      hot-keys = false;
      intellihide-mode = "ALL_WINDOWS";
      pressure-threshold = 0.0;
      preview-size-scale = 0.3;
      require-pressure-to-show = false;
      running-indicator-style = "DEFAULT";
      show-favorites = true;
      show-mounts = true;
      show-running = true;
      show-show-apps-button = false;
      show-trash = false;
      show-windows-preview = false;
    };

    "org/gnome/shell/extensions/gnome-ui-tune" = {
      hide-search = true;
    };

    "org/gnome/shell/extensions/hidetopbar" = {
      animation-time-autohide = 0.1;
      animation-time-overview = 0.2;
      enable-active-window = true;
      enable-intellihide = true;
      mouse-sensitive = true;
      pressure-threshold = 20;
      pressure-timeout = 1000;
      show-in-overview = true;
    };

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

    "org/gnome/shell/extensions/mullvadindicator" = {
      show-menu = true;
    };

    "org/gnome/shell/extensions/system-monitor" = {
      background = "#00000000";
      battery-display = false;
      battery-style = "graph";
      center-display = false;
      compact-display = true;
      cpu-individual-cores = true;
      cpu-show-text = true;
      disk-display = false;
      gpu-display = false;
      gpu-graph-width = 1;
      gpu-style = "graph";
      icon-display = false;
      move-clock = false;
      show-tooltip = false;
      thermal-display = false;
      thermal-sensor-file = "/sys/class/hwmon/hwmon8/temp1_input";
      thermal-style = "graph";
    };

    "org/gnome/shell/extensions/tiling-assistant" = {
      activate-layout0 = [];
      activate-layout1 = [];
      activate-layout2 = [];
      activate-layout3 = [];
      auto-tile = [];
      change-favorite-layout = [];
      changelog-version = 27;
      debugging-free-rects = [];
      debugging-show-tiled-rects = [];
      default-move-mode = "Edge Tiling";
      import-layout-examples = false;
      move-favorite-layout-mod = "Alt";
      screen-gap = 2;
      search-popup-layout = [];
      tile-bottom-half = [ "<Super>KP_2" ];
      tile-bottomleft-quarter = [ "<Super>KP_1" ];
      tile-bottomright-quarter = [ "<Super>KP_3" ];
      tile-edit-mode = [];
      tile-left-half = [ "<Super>KP_4" ];
      tile-maximize = [ "<Super>KP_5" ];
      tile-right-half = [ "<Super>KP_6" ];
      tile-top-half = [ "<Super>KP_8" ];
      tile-topleft-quarter = [ "<Super>KP_7" ];
      tile-topright-quarter = [ "<Super>KP_9" ];
      toggle-tiling-popup = [];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Nordic-darker";
    };

    "org/gnome/shell/extensions/x11gestures" = {
      swipe-fingers = 4;
    };

    "org/gnome/shell/overrides" = {
      edge-tiling = false;
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
      locations = "[<(uint32 2, <('Berlin-Schoenefeld', 'EDDB', false, [(0.91426163401859872, 0.23591034304566436)], @a(dd) [])>)>]";
    };

    "org/gnome/shell/world-clocks" = {
      locations = "@av []";
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtimelog" = {
      detail-level = "grouped";
      gtk-completion = true;
      hours = 8.0;
      list-email = "activity-list@example.com";
      name = "Anonymous";
      office-hours = 9.0;
      remote-task-list = false;
      report-style = "plain";
      sender = "";
      settings-migrated = true;
      show-task-pane = true;
      task-list-url = "";
      virtual-midnight = mkTuple [ 2 0 ];
      window-position = mkTuple [ 223 259 ];
    };

    "org/gtk/gtk4/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 0.0 0.0 ]) (mkTuple [ 1.0 1.0 ]) ];
      selected-color = mkTuple [ true 0.0 ];
    };

    "org/gtk/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 0.368627 0.505882 ]) (mkTuple [ 0.0 0.2 ]) (mkTuple [ 0.921569 0.796078 ]) (mkTuple [ 0.839216 0.705882 ]) (mkTuple [ 0.745098 0.807843 ]) (mkTuple [ 0.815686 0.529412 ]) (mkTuple [ 1.0 0.0 ]) (mkTuple [ 0.639216 0.745098 ]) ];
      selected-color = mkTuple [ true 0.368627 ];
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 180;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 345 70 ];
      window-size = mkTuple [ 1231 902 ];
    };

  };
}
