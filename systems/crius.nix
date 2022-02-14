{ config, pkgs, lib, ... }:

{
  # Import modules
  imports = [
    ./modules/backup.nix
    ./modules/common.nix
    ./modules/innernet.nix
    # For multiple monitors, I didable nvidia.nix and enable intel.nix
    #./modules/nvidia.nix
    ./modules/intel.nix
    ./modules/printing.nix
    ./modules/syncthing.nix
    ./modules/virtualisation.nix
  ];

  # Confifure networking
  networking.hostName = "crius";
  networking.hostId = "8d7271a2";
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  environment.etc = {
    "NetworkManager/system-connections".source =
      "/persist/etc/NetworkManager/system-connections/";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "gb";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager = {
    gdm.enable = true;
    gdm.wayland = true;
  };

  # Enable libinput and gestures via touchegg
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.tapping = true;
  services.touchegg.enable = true;

  # From auto-generated hardware.nix
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];

  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "rpool/local/root";
    fsType = "zfs";
    options = [ "x-gvfs-hide" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/113A-9311";
    fsType = "vfat";
    options = [ "x-gvfs-hide" ];
  };

  fileSystems."/nix" = {
    device = "rpool/local/nix";
    fsType = "zfs";
    options = [ "x-gvfs-hide" ];
  };

  fileSystems."/home" = {
    device = "rpool/safe/home";
    fsType = "zfs";
    options = [ "x-gvfs-hide" ];
  };

  fileSystems."/persist" = {
    device = "rpool/safe/persist";
    fsType = "zfs";
    neededForBoot = true;
    options = [ "x-gvfs-hide" ];
  };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
