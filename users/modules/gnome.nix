{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Gnome-related
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.executor
    gnomeExtensions.floating-dock
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.just-perfection
    gnomeExtensions.mullvad-indicator
    gnomeExtensions.tiling-assistant
    gnome.gnome-tweaks
    gnome.dconf-editor
    dconf2nix
  ];

  imports = [
    # /org/gnome/desktop/*
    ./dconf/desktop.nix
    # /org/gnome/shell/keybindings
    ./dconf/shell-keybindings.nix
    # /org/gnome/shell/extensions/*
    ./dconf/ext-clipboard-indicator.nix
    ./dconf/ext-floating-dock.nix
    ./dconf/ext-gnome-ui-tune.nix
    ./dconf/ext-just-perfection.nix
    ./dconf/ext-tiling-assistant.nix
    # TODO ./dconf/ext-executor
  ];
}
