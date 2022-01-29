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
  # Import modules
  imports = [
    ./modules/backup.nix
    ./modules/common.nix
    ./modules/innernet.nix
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.layout = "gb";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager = {
    gdm.enable = true;
    gdm.wayland = false;
  };

  # Enable libinput and gestures via touchegg
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.tapping = true;
  services.touchegg.enable = true;

  # Enable NVIDIA drivers (with PRIME)
  nixpkgs.config.allowUnfree = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaPersistenced = true;
  hardware.nvidia.prime = {
    offload.enable = true;
    # Bus ID of the Intel GPU
    intelBusId = "PCI:0:2:0";
    # Bus ID of the NVIDIA GPU
    nvidiaBusId = "PCI:1:0:0";
  };

  # Install nvidia-offload script
  environment.systemPackages = [ nvidia-offload ];

  # See: https://github.com/NixOS/nixpkgs/issues/103746
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # From auto-generated hardware.nix
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "rpool/local/root";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/113A-9311";
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

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
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
