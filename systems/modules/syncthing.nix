{ config, lib, pkgs, ... }:

{
  services = {
    syncthing = {
      enable = true;
      overrideDevices =
        true; # overrides any devices added or deleted through the WebUI
      overrideFolders =
        true; # overrides any folders added or deleted through the WebUI
      # devices = {
      #   "kronos" = { id = "DEVICE-ID-GOES-HERE"; };
      #   "crius" = { id = "DEVICE-ID-GOES-HERE"; };
      # };
      folders = {
        "org" = {
          path = "/home/lino/Exocortex/org";
          devices = [ "kronos" "crius" ];
        };
        "reading" = {
          path = "/home/lino/Exocortex/reading";
          devices = [ "kronos" "crius" ];
        };
      };
    };
  };
}
