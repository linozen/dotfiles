{ config, lib, pkgs, ... }:

{
  # libvirtd
  virtualisation.libvirtd.enable = true;

  # Enable docker
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    autoPrune.enable = true;
  };

}
