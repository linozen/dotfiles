{ config, pkgs, lib, ... }:

{
  imports = [
    # Import hardware configuration
    ./kronos-hardware.nix
    ./modules/innernet.nix
    ./modules/syncthing.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    # nixPath = [
    #   "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    #   "nixos-config=/home/lino/.dotfiles/configuration.nix"
    #   "/nix/var/nix/profiles/per-user/root/channels"
    # ];
  };

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
  # hardware.nvidia.modesetting.enable = true;

  # Configure NVIDIA RTX 2070 Super
  # hardware.nvidia.nvidiaPersistenced = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable

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
    # TODO Set up autoReplication of all important datasets
  };

  # Don't enable auto-optimisation for now but remove generations older than two weeks
  # nix.autoOptimiseStore = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };

  # Set timezone
  time.timeZone = "Europe/Berlin";

  # TODO Confifure Networking
  networking.hostId = "2ce35e9c";
  networking.hostName = "kronos";
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  # networking.interfaces.enp0s5.useDHCP = false;

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

  hardware.opengl.driSupport32Bit = true;

  # libvirtd
  virtualisation.libvirtd.enable = true;

  # Enable docker
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    autoPrune.enable = true;
  };

  # Install system applications
  environment.systemPackages = [
    pkgs.age
    pkgs.alacritty
    pkgs.brightnessctl
    pkgs.firefox
    pkgs.gcc
    pkgs.git
    pkgs.glxinfo
    pkgs.gnupg
    pkgs.innernet
    pkgs.mullvad-vpn
    pkgs.pinentry-gnome
    pkgs.vim
  ];

  # Configure Backups
  # See: https://christine.website/blog/borg-backup-2021-01-09
  services.borgbackup.jobs."borgbase" = {
    paths = [ "/home" "/persist" ];
    exclude = [
      # Large paths in /persist
      "/persist/var/lib/docker"
      "/persist/var/lib/libvirt"

      # Temporary files and caches in /home
      "/home/*/.cache"
      "/home/*/.compose-cache"
      "/home/*/cache2"
      "/home/*/Cache"
      "/home/*/.npm/_cacache"
      "/home/*/__pycache__"
      "/home/*/target"
      "/home/*/go/bin"
      "/home/*/go/pkg"
      "/home/*/node_modules"
      "/home/*/bower_components"
      "/home/*/_build"
      "/home/*/.tox"
      "/home/*/venv"
      "/home/*/.venv"
    ];
    repo = "oxti13j3@oxti13j3.repo.borgbase.com:repo";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /persist/borg/passphrase";
    };
    environment.BORG_RSH = "ssh -i /persist/borg/ssh_key";
    compression = "auto,lzma";
    startAt = "hourly";
    prune.keep = {
      within = "2d"; # Keep all archives from the last two days
      daily = 14;
      weekly = 4;
      monthly = -1; # Keep at least one archive for each month
    };
  };

  # Enable fish for vendot completions
  programs.fish.enable = true;

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

  # TODO Enable innernet (fsfe & homenet)
  # services.innernet = {
  #   enable = true;
  # };

  # Symlink important stuff in /etc to /persist/etc
  environment.etc = {
    "mullvad-vpn".source = "/persist/etc/mullvad-vpn/";
    "innernet".source = "/persist/etc/innernet/";
  };

  # Symlink important stuff in /var to /persist/var
  systemd.tmpfiles.rules = [
    "L /var/lib/bluetooth - - - - /persist/var/lib/bluetooth"
    "L /var/lib/innernet - - - - /persist/var/lib/innernet"
  ];

  # Configure SSH Daemon
  services.openssh = {
    enable = true;
    openFirewall = true;
    passwordAuthentication = false;
  };

  # Configure users declaratively
  users = {
    mutableUsers = false;
    users = {
      root = {
        # Include only for first boot
        initialHashedPassword =
          "$6$L9J7/mFLT5g29nZr$B1sP8NckbzHUxKxZ9bf4/FXmYbN4pLC3ovA7H058ONOD8lCcVgcM/.xlMexpeDFu9EZl0pbL.ZDe7df7t74PB0";
        # ---
        # This file includes nothing but the hashed version of the password for the root user
        passwordFile = "/persist/passwords/root";
      };
      lino = {
        isNormalUser = true;
        createHome = true;
        # See above
        initialHashedPassword =
          "$6$pNdUmZBPAZuuDGbT$uNqIH6r9yMxag53XUZURfwXK0iMgBHH1/5s/poJtwy5Z2L6mYJrP7FeudbkZ14MqHKy6n0FLDsURWmp6QfUWt/";
        passwordFile = "/persist/passwords/lino";
        extraGroups = [ "wheel" "docker" "qemu-libvirtd" "libvirtd" ];
        group = "users";
        uid = 1000;
        home = "/home/lino";
        shell = pkgs.fish;
        openssh.authorizedKeys.keys = [
          "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDqf8875YKiWOmppVNyKIJLFICCjMsUFVK9SnKwyupjSe/8ni0WgzYtT5bU4rJ9EjHiX5VEdJFU5QqkceTSO0aM="
        ];
      };
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
