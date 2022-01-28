{ config, lib, pkgs, ... }:

{
  # Symlink application's configuration files
  home.file = {
    ".config/qt5ct/qt5ct.conf".source = ./qt5ct.conf;
    ".ssh/config".source = ./ssh/client/config;
    ".config/Element/config.json".source = ./element/config.json;
  };
}
