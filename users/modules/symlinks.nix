{ config, lib, pkgs, ... }:

{
  # Symlink application's configuration files
  home.file = {
    ".config/qt5ct/qt5ct.conf".source = ./qt5ct.conf;
    ".ssh/config".source = ./ssh/client/config;
    ".config/Element/config.json".source = ./element/config.json;
    # TODO Setup git using Nix
    # See: https://nixos.wiki/wiki/Git
    ".gitconfig".source = ./gitconfig/.gitconfig;
    ".gitconfig-fsfe".source = ./gitconfig/.gitconfig-fsfe;
  };
}
