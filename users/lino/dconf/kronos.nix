# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = {
    "apps/seahorse/listing" = {
      item-filter = "personal";
      keyrings-selected = [ "secret-service:///org/freedesktop/secrets/collection/login" ];
    };

    "apps/seahorse/windows/key-manager" = {
      height = 775;
      width = 1546;
    };

    "ca/desrt/dconf-editor" = {
      saved-pathbar-path = "/org/freedesktop/tracker/miner/files/";
      saved-view = "/org/";
      window-height = 500;
      window-is-maximized = false;
      window-width = 1067;
    };

    "org/gnome/Disks" = {
      image-dir-uri = "file:///home/lino/Downloads";
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

    "org/gnome/Music" = {
      window-maximized = false;
      window-position = [ 2875 209 ];
      window-size = [ 1556 948 ];
    };

    "org/gnome/Weather" = {
      locations = "[<(uint32 2, <('Berlin-Schoenefeld', 'EDDB', false, [(0.91426163401859872, 0.23591034304566436)], @a(dd) [])>)>]";
    };

    "org/gnome/baobab/ui" = {
      window-size = mkTuple [ 960 600 ];
      window-state = 87168;
    };

    "org/gnome/calculator" = {
      accuracy = 9;
      angle-units = "degrees";
      base = 10;
      button-mode = "basic";
      number-format = "automatic";
      show-thousands = false;
      show-zeroes = false;
      source-currency = "";
      source-units = "degree";
      target-currency = "";
      target-units = "radian";
      window-position = mkTuple [ 2608 72 ];
      word-size = 64;
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
      last-panel = "sound";
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
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "gnome-power-panel" "alacritty" "firefox" "org-gnome-nautilus" "element-desktop" "signal-desktop" "emacsclient" "gnome-control-center" "org-gnome-evolution-alarm-notify" "filezilla" ];
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

    "org/gnome/desktop/notifications/application/filezilla" = {
      application-id = "filezilla.desktop";
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

    "org/gnome/desktop/notifications/application/org-gnome-music" = {
      application-id = "org.gnome.Music.desktop";
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

    "org/gnome/desktop/sound" = {
      event-sounds = true;
      theme-name = "__custom";
    };

    "org/gnome/desktop/wm/keybindings" = {
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

    "org/gnome/desktop/wm/preferences" = {
      auto-raise = true;
      button-layout = "appmenu:minimize,maximize,close";
      focus-mode = "sloppy";
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
      window-state = mkTuple [ 1360 500 ];
    };

    "org/gnome/gnome-system-monitor/disktreenew" = {
      col-6-visible = true;
      col-6-width = 0;
    };

    "org/gnome/gnome-system-monitor/proctree" = {
      columns-order = [ 0 1 2 3 4 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 ];
      sort-col = 8;
      sort-order = 0;
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = false;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = false;
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
      initial-size = mkTuple [ 1515 677 ];
      maximized = false;
      sidebar-width = 236;
    };

    "org/gnome/nm-applet/eap/15ad66ab-46e4-433d-a77a-189100621b95" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
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
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" ];
      help = [];
      home = [ "<Super>f" ];
      www = [ "<Super>b" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>space";
      command = "alacritty";
      name = "Lauch Terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Alt>Escape";
      command = "emacsclient -nc";
      name = "Launch Emacs (Client)";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = true;
    };

    "org/gnome/shell" = {
      command-history = [ "r" ];
      disable-user-extensions = false;
      disabled-extensions = [ "native-window-placement@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "just-perfection-desktop@just-perfection" "dash-to-dock@micxgx.gmail.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "system-monitor@paradoxxx.zero.gmail.com" "syncthingicon@jay.strict@posteo.de" ];
      enabled-extensions = [ "x11gestures@joseexposito.github.io" "user-theme@gnome-shell-extensions.gcampax.github.com" "tiling-assistant@leleat-on-github" "mullvadindicator@pobega.github.com" "hidetopbar@mathieu.bidon.ca" "gnome-ui-tune@itstime.tech" "floating-dock@nandoferreira_prof@hotmail.com" "clipboard-indicator@tudmotu.com" "syncthing@gnome.2nv2u.com" ];
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
      toggle-menu = [];
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

    "org/gnome/shell/extensions/user-theme" = {
      name = "Nordic-darker";
    };

    "org/gnome/shell/extensions/x11gestures" = {
      swipe-fingers = 4;
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      toggle-application-view = [];
      toggle-overview = [];
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
      task-pane-position = 998;
      virtual-midnight = mkTuple [ 2 0 ];
      window-position = mkTuple [ 176 41 ];
      window-size = mkTuple [ 1248 1358 ];
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
      window-position = mkTuple [ 2894 250 ];
      window-size = mkTuple [ 1231 902 ];
    };

    "org/virt-manager/virt-manager" = {
      manager-window-height = 550;
      manager-window-width = 550;
    };

    "org/virt-manager/virt-manager/confirm" = {
      forcepoweroff = true;
    };

    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };

    "org/virt-manager/virt-manager/conns/qemu:system" = {
      window-size = mkTuple [ 816 729 ];
    };

    "org/virt-manager/virt-manager/details" = {
      show-toolbar = true;
    };

    "org/virt-manager/virt-manager/vmlist-fields" = {
      disk-usage = false;
      network-traffic = false;
    };

    "org/virt-manager/virt-manager/vms/474ecb6eb1fa4bf48060ef2a8abac31d" = {
      autoconnect = 1;
      scaling = 1;
      vm-window-size = mkTuple [ 1024 832 ];
    };

    "org/virt-manager/virt-manager/vms/524c09a233c2433b9dffbdb91456554b" = {
      autoconnect = 1;
      scaling = 1;
      vm-window-size = mkTuple [ 1024 832 ];
    };

  };
}
