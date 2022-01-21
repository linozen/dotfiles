{ config, lib, pkgs, ... }:

{
  services = {
    syncthing = {
      enable = true;
      user = "lino";
      configDir = "/home/lino/.config/syncthing";
      # Be declarative
      overrideDevices = true;
      overrideFolders = true;
      devices = {
        "kronos" = {
          id =
            "NOTUJRB-GLRQQSR-UXVA6HC-P3NUMA3-VONDKV4-3XWQAUM-6M2PF7D-QJIERAK";
        };
        "crius" = {
          id =
            "QQ6XDR3-I4DVVCN-KRR6V3X-4OTVYWY-CQLQFQ4-KBWQCXC-VVYJF7H-ZLPYSQC";
        };
      };
      folders = {
        "org" = {
          path = "/home/lino/Exocortex/org";
          devices = [ "kronos" "crius" ];
          ignorePerms = false;
        };
        "reading" = {
          path = "/home/lino/Exocortex/reading";
          devices = [ "kronos" "crius" ];
          ignorePerms = false;
        };
      };
    };
  };
}
