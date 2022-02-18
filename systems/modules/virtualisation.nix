{ config, lib, pkgs, ... }:

{
  # Enable libvirtd
  virtualisation.libvirtd.enable = true;

  # Enable docker
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
}
