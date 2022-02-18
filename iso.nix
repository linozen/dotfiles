{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix" ];

  # use the latest Linux kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_15;

  # firmware
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  # boot.supportedFilesystems =
  #   lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];
}
