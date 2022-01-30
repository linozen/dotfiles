{ config, pkgs, lib, ... }:

{
  # Import modules
  imports = [
    ./modules/backup.nix
    ./modules/common.nix
    ./modules/innernet.nix
    ./modules/printing.nix
    ./modules/syncthing.nix
    ./modules/virtualisation.nix
  ];

  # Configure networking
  networking.hostName = "kronos";
  networking.hostId = "2ce35e9c";
  networking.networkmanager.enable = true;
  networking.useDHCP = false;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "gb";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager = {
    gdm.enable = true;
    gdm.wayland = false;
  };

  # Enable NVIDIA drivers (no PRIME)
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # From auto-generated hardware.nix
  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];

  # See: https://nixos.wiki/wiki/ZFS
  boot.kernelParams = [ "nohibernate" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "rpool/local/root";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/7829-731E";
    fsType = "vfat";
  };

  fileSystems."/nix" = {
    device = "rpool/local/nix";
    fsType = "zfs";
  };

  fileSystems."/home" = {
    device = "rpool/safe/home";
    fsType = "zfs";
  };

  fileSystems."/persist" = {
    device = "rpool/safe/persist";
    fsType = "zfs";
    neededForBoot = true;
  };

  swapDevices = [{
    device = "/dev/disk/by-partuuid/03d2beb7-7bde-f343-9501-5c9c83210eca";
    randomEncryption.enable = true;
  }];

  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
