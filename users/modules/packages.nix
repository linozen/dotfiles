{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Music
    deadbeef
    cmus
    exaile
    # Images
    gthumb
    image_optim
    unzip
    # Nix-related
    nix-prefetch-git
    # Theming
    pkgs.libsForQt5.qtstyleplugin-kvantum
    papirus-icon-theme
    nordic
    rubik
    nerdfonts
    # Communication
    mumble
    tdesktop
    signal-desktop
    element-desktop
    # Secrets
    bitwarden
    yubikey-manager
    age
    # Time-tracking
    gtimelog
    # Research & Learning
    anki
    pandoc
    plantuml
    xournal
    zotero
    # SFTP
    filezilla
    # DBs
    beekeeper-studio
    # Calendar Sync
    evolution
    # Office
    libreoffice
    # TODO Move to virtualisation system modules
    virt-manager
    quickemu
    vagrant
    docker-compose
    ctop
    # Development
    drone-cli
    gnumake
  ];
}
