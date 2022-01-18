{ config, pkgs, lib, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in {
  imports = [
    # Import hardware configuration
    ./hardware-configuration.nix
    # Import home-manager module
    <home-manager/nixos>
  ];

  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/home/lino/.dotfiles/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  # Set (perhaps temporarily) higher limits to not run into problems
  # when installing Doom Emacs
  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "4096";
  }];

  # Needed for NVIDIA drivers
  nixpkgs.config.allowUnfree = true;

  # Use latest kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.nvidia.modesetting.enable = true;

  # Configure NVIDIA RTX 2070 Max-Q
  hardware.nvidia.nvidiaPersistenced = true;
  hardware.nvidia.prime = {
    offload.enable = true;
    # Bus ID of the Intel GPU
    intelBusId = "PCI:0:2:0";
    # Bus ID of the NVIDIA GPU
    nvidiaBusId = "PCI:1:0:0";
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # See: https://grahamc.com/blog/nixos-on-zfs
  boot.kernelParams = [ "elevator=none" ];

  # See: https://grahamc.com/blog/erase-your-darlings
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r rpool/local/root@blank
    while true; do
      stty -echo
      read -p "Passphrase for datasets: " PASS
      stty echo
      echo "$PASS" | zfs load-key rpool/safe/home || continue
      echo "$PASS" | zfs load-key rpool/safe/persist || continue
      break
    done
  '';
  # Disable native password prompt as I want to type in my password only once
  boot.zfs.requestEncryptionCredentials = false;

  services.zfs = {
    autoScrub.enable = true;
    autoSnapshot.enable = true;
    # TODO Set up autoReplication
  };

  # TODO Backups of /safe/persist

  # Set timezone
  time.timeZone = "Europe/Berlin";

  # TODO Confifure Networking
  networking.hostId = "8d7271a2";
  networking.hostName = "crius";
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.layout = "gb";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager = {
    gdm.enable = true;
    gdm.wayland = false;
    autoLogin = {
      enable = true;
      user = "lino";
    };
  };

  # See: https://github.com/NixOS/nixpkgs/issues/103746
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Configure Gnome
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome = { gnome-settings-daemon.enable = true; };
  programs.dconf.enable = true;
  environment.gnome.excludePackages = [
    pkgs.gnome.cheese
    pkgs.gnome-photos
    pkgs.gnome.gnome-music
    pkgs.gnome.gnome-terminal
    pkgs.gnome.gedit
    pkgs.epiphany
    pkgs.gnome.gnome-characters
    pkgs.gnome.totem
    pkgs.gnome.tali
    pkgs.gnome.iagno
    pkgs.gnome.hitori
    pkgs.gnome.atomix
    pkgs.gnome-tour
    pkgs.gnome.geary
  ];

  # Start SSH agent for legacy keys
  programs.ssh.startAgent = true;

  # Enable GnuPG agent
  programs.gnupg.agent = { enable = true; };

  # This overlay is needed until a new version tag is approved
  # See:
  # - https://github.com/NixOS/nixpkgs/issues/145392
  # - https://github.com/FiloSottile/yubikey-agent/tags
  nixpkgs.overlays = [
    (self: super: {
      yubikey-agent = super.buildGoModule {
        inherit (super.yubikey-agent.drvAttrs)
          pname doCheck nativeBuildInputs buildInputs buildPhase installPhase
          postPatch subPackages postInstall;
        inherit (super.yubikey-agent) meta;
        version = "0.1.5+pr";
        src = super.fetchFromGitHub {
          owner = "FiloSottile";
          repo = "yubikey-agent";
          rev = "8190e59004113c1c5aee031ea37a4a5513900456";
          sha256 = "06qg2iy3145lg1r5j6h7fk5byawvh806qr54vb3vpcshlihi4py1";
        };
        vendorSha256 = "gTZERpmX/1bXXqjK5jTirXBEo+LAvoBdHF7ugsc0HkE=";
      };
    })
  ];
  # Enable YubiKey agent for a secure SSH keys stored on my YubiKey
  # TODO Do the same on backup YubiKey
  services.yubikey-agent.enable = true;

  # Enable QT theming via qt5ct
  qt5.enable = false;
  programs.qt5ct.enable = true;

  # Enable libinput and gestures via touchegg
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.tapping = true;
  services.touchegg.enable = true;

  # Install system applications
  environment.systemPackages = [
    nvidia-offload
    pkgs.gcc
    pkgs.vim
    pkgs.mullvad-vpn
    pkgs.brightnessctl
    pkgs.pinentry-gnome
  ];

  # Enable Yubikey
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
  security.pam.yubico = {
    enable = true;
    debug = true;
    mode = "challenge-response";
  };

  # Enable Mullvad VPN
  services.mullvad-vpn.enable = true;

  # Symlink important stuff in /etc to /persist/etc
  environment.etc = {
    "NetworkManager/system-connections".source =
      "/persist/etc/NetworkManager/system-connections/";
    "mullvad-vpn".source = "/persist/etc/mullvad-vpn/";
  };

  # Symlink important stuff in /var to /persist/var
  systemd.tmpfiles.rules =
    [ "L /var/lib/bluetooth - - - - /persist/var/lib/bluetooth" ];

  # Configure users declaratively
  users = {
    mutableUsers = false;
    users = {
      root = {
        # Include only for first boot
        # initialHashedPassword =
        #   "$6$L9J7/mFLT5g29nZr$B1sP8NckbzHUxKxZ9bf4/FXmYbN4pLC3ovA7H058ONOD8lCcVgcM/.xlMexpeDFu9EZl0pbL.ZDe7df7t74PB0";
        # ---
        # This file includes nothing but the hashed version of the password for the root user
        passwordFile = "/persist/passwords/root";
      };
      lino = {
        isNormalUser = true;
        createHome = true;
        # See above
        # initialHashedPassword =
        #   "$6$pNdUmZBPAZuuDGbT$uNqIH6r9yMxag53XUZURfwXK0iMgBHH1/5s/poJtwy5Z2L6mYJrP7FeudbkZ14MqHKy6n0FLDsURWmp6QfUWt/";
        passwordFile = "/persist/passwords/lino";
        extraGroups = [ "wheel" ];
        group = "users";
        uid = 1000;
        home = "/home/lino";
        useDefaultShell = true;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICoo8noU60lsn//NcPar2QxwLtnkn1ZODVIJddUylYCu lino@tower"
        ];
      };
    };
  };

  home-manager.users.lino = { config, pkgs, ... }: {
    # Enable Emacs overlay
    nixpkgs.overlays = [
      (import (builtins.fetchGit {
        url = "https://github.com/nix-community/emacs-overlay.git";
        ref = "master";
        rev = "7b8d3f12dc35a1dbf93a2a6be30d9e6b157ba17e";
      }))
    ];
    # Install user applications
    home.packages = with pkgs; [
      # Basic
      alacritty
      git
      firefox
      gnupg
      glxinfo
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
      # Bitwarden
      # TODO Setup WebAuthn and and TOTP for both keys
      bitwarden
      bitwarden-cli
      # YubiKey
      yubikey-manager
      # Email
      age
      # (Doom) Emacs dependencies
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
      nodePackages.typescript-language-server
      texlive.combined.scheme-medium
    ];

    # TODO Backups of user data

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
    imports = [ ./dconf.nix ];

    # Symlink application's configuration files
    home.file = {
      ".config/alacritty/alacritty.yml".source = ./alacritty.yml;
      ".config/qt5ct/qt5ct.conf".source = ./qt5ct.conf;
      ".ssh/config".source = ./ssh/client/config;
      ".doom.d".source = config.lib.file.mkOutOfStoreSymlink ./doom;
      ".config/Element/config.json".source = ./element/config.json;
    };

    # TODO Setup git

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
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
