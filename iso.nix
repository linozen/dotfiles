{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix" ];

  # use the latest Linux kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_15;

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  # boot.supportedFilesystems =
  #   lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];
}
