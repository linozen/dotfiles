{ config, lib, pkgs, ... }:

{
  # Enable libvirtd
  virtualisation.libvirtd.enable = true;

  # Needed for nvidia-docker
  hardware.opengl.driSupport32Bit = true;

  # Enable docker
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    autoPrune.enable = true;
  };

}
