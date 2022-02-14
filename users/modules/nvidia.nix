{ config, lib, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in {

  # Enable NVIDIA drivers (with PRIME)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaPersistenced = true;
  hardware.nvidia.prime = {
    offload.enable = true;
    # Bus ID of the Intel GPU
    intelBusId = "PCI:0:2:0";
    # Bus ID of the NVIDIA GPU
    nvidiaBusId = "PCI:1:0:0";
  };

  environment.systemPackages = [
    # Extension needed for gesture support in Gnome under X11
    pkgs.gnomeExtensions.x11-gestures
    # Offload script
    nvidia-offload
  ];
}
