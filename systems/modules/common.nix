{ config, lib, pkgs, ... }:

{
  # Enable Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Don't enable auto-optimisation for now
  # nix.autoOptimiseStore = true;

  # Remove generations older than two weeks
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
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

  # Enable ZFS services
  services.zfs = {
    autoScrub.enable = true;
    autoSnapshot.enable = true;
    # TODO Set up autoReplication of all important datasets
  };

  # Set timezone
  time.timeZone = "Europe/Berlin";

  # Configure and slim down Gnome
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
  services.yubikey-agent.enable = true;

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

  # Enable Mullvad VPN
  services.mullvad-vpn.enable = true;

  # TODO Enable innernet (fsfe & homenet)

  # Enable QT theming via qt5ct
  qt5.enable = false;
  programs.qt5ct.enable = true;
}
