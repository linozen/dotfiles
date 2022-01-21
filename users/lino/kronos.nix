{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "lino";
  home.homeDirectory = "/home/lino";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.overlays = [
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/emacs-overlay.git";
      ref = "master";
      rev = "7b8d3f12dc35a1dbf93a2a6be30d9e6b157ba17e";
    }))
  ];
  # Install user applications
  home.packages = with pkgs; [
    # Gnome-related
    gnomeExtensions.x11-gestures
    gnomeExtensions.tiling-assistant
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.mullvad-indicator
    gnomeExtensions.hide-top-bar
    gnomeExtensions.floating-dock
    gnomeExtensions.clipboard-indicator
    gnome.gnome-tweaks
    dconf2nix
    # Nix-related
    nix-prefetch-git
    # Theming
    pkgs.libsForQt5.qtstyleplugin-kvantum
    papirus-icon-theme
    nordic
    rubik
    nerdfonts
    # Communication
    signal-desktop
    element-desktop
    # Secrets
    # TODO Setup WebAuthn and and TOTP for both keys
    bitwarden
    bitwarden-cli
    yubikey-manager
    age
    # Terminal
    alacritty
    tab-rs
    # Time-tracking
    gtimelog
    # Research
    zotero
    # Doom Emacs
    fd
    gnutls
    imagemagick
    zstd
    emacs-all-the-icons-fonts
    nixfmt
    (ripgrep.override { withPCRE2 = true; })
    python3Minimal
    python39Packages.pywal
    (aspellWithDicts (ds: with ds; [ de en en-computers en-science ]))
    sqlite
    texlive.combined.scheme-medium
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
  ];

  # TODO Setup XMPP (Dino)

  # Configure GnuPG
  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ./pgp/fsfe_max.key;
        trust = "marginal";
      }
      {
        source = ./pgp/fsfe_mk.key;
        trust = "marginal";
      }
      {
        source = ./pgp/fsfe_patrick.key;
        trust = "marginal";
      }
      {
        source = ./pgp/fsfe_heiki.key;
        trust = "marginal";
      }
      {
        source = ./pgp/fsfe_heiki.key;
        trust = "marginal";
      }
      {
        source = ./pgp/fsfe_linda.key;
        trust = "marginal";
      }
    ];
  };

  # Import (mostly Gnome related) dconf settings
  # TODO Use common.nix or modules?
  # See: https://nix-community.github.io/home-manager/ Section 5.3
  imports = [ ./dconf/kronos.nix ];

  # Symlink application's configuration files
  home.file = {
    ".config/alacritty/alacritty.yml".source = ./alacritty.yml;
    ".config/qt5ct/qt5ct.conf".source = ./qt5ct.conf;
    ".ssh/config".source = ./ssh/client/config;
    ".config/Element/config.json".source = ./element/config.json;
    ".config/fish/fish_variables".source = ./fish_variables;
    ".config/starship.toml".source = ./starship.toml;
  };
  # Configure fish shell
  programs.fish.enable = true;
  programs.fish.plugins = [{
    name = "z";
    src = pkgs.fetchFromGitHub {
      owner = "jethrokuan";
      repo = "z";
      rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
      sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
    };
  }];
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # TODO Setup git

  # Install Emacs with natively compiled backend using overlay:
  # https://gist.github.com/mjlbach/179cf58e1b6f5afcb9a99d4aaf54f549
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = (epkgs: [
      # Needed for terminal emulation inside Emacs
      epkgs.vterm
      # Needed for reading mails inside Emacs
      pkgs.mu
    ]);
  };

  # Make Emacs client work correctly
  xsession.enable = true;
  services.emacs.enable = true;
  systemd.user.services.emacs.Unit = {
    After = [ "graphical-session-pre.target" ];
    PartOf = [ "graphical-session.target" ];
  };

  # Setup mail indexing with mbsync / mu
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.mu.enable = true;
  accounts.email = {
    # Main account used for fetching all and sending personal mail
    accounts.mailbox = {
      address = "linus@sehn.tech";
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
      };
      imap = {
        host = "imap.mailbox.org";
        port = 993;
      };
      msmtp.enable = true;
      smtp = {
        host = "smtp.mailbox.org";
        port = 465;
      };
      primary = true;
      userName = "linus@sehn.tech";
      passwordCommand = "gpg --decrypt ~/.mailpass-mailbox.gpg 2>/dev/null";
    };
    # Account for sending mails via FSFE mailserver
    accounts.fsfe = {
      address = "linus@fsfe.org";
      msmtp.enable = true;
      smtp = {
        host = "mail.fsfe.org";
        port = 587;
        tls.useStartTls = true;
      };
      userName = "linus@fsfe.org";
      passwordCommand = "gpg --decrypt ~/.mailpass-fsfe.gpg 2>/dev/null";
    };
  };

}
