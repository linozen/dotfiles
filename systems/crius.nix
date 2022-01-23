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
    ./crius-hardware.nix
    # Import modules
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
    pkgs.age
    pkgs.mullvad-vpn
    pkgs.brightnessctl
    pkgs.pinentry-gnome
    pkgs.alacritty
    pkgs.git
    pkgs.firefox
    pkgs.gnupg
    pkgs.glxinfo
  ];

  # Configure Backups
  # See: https://christine.website/blog/borg-backup-2021-01-09
  # First, make BorgBase repo a known host
  programs.ssh.knownHosts = {
    borgbaseEd25519 = {
      hostNames = [ "oxti13j3.repo.borgbase.com" ];
      publicKey =
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMS3185JdDy7ffnr0nLWqVy8FaAQeVh1QYUSiNpW5ESq";
    };
    borgbaseRsa = {
      hostNames = [ "oxti13j3.repo.borgbase.com" ];
      publicKey =
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwHsO5g7kAEpqcK4bpHCUKYV1cKCUNwVEVsDQyfj7N8L92E21n+aEhIX2Nh/kFs1W9D/pgsWQBAbco9e/ORuagHrO8hUQtbda5Z31PAo4eipwP17VQr5rF3seaJJNFV72v89PGwMOWQwvoJte+yngC6PYGKJ+w63SRtflihAmf4xa5Tci/f6jbX6t32m2F3bnephVzQO6anGXvGPR8QYQXzSu/27+LaKnLd2Kugb1Ytbo0+6kioa60HWejIZ/mCrCHXYpi0jAllaYEuAsTqFWf/OFUHrKWwRAJD0TV43O1++vLlxY85oQxIgc4oUbm93dXmDBssrTnqqq2jqonteUr";
    };
    borgbaseEdsaSha2Nistp256 = {
      hostNames = [ "oxti13j3.repo.borgbase.com" ];
      publicKey =
        "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBOstKfBbwVOYQh3J7X4nzd6/VYgLfaucP9z5n4cpSzcZAOKGh6jH8e1mhQ4YupthlsdPKyFFZ3pKo4mTaRRuiJo=";
    };
  };
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
        shell = pkgs.fish;
        openssh.authorizedKeys.keys = [
          "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBODwLZY9WHSyvpG1C0lns1e3xZQpIL6Gj1ZZsA61BCjK3agBqHd7pPPZOpCGt0JBNlvc0ZULp93ARZQSPF3rNgs="
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
