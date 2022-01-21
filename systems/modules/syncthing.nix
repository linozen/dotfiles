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
            "IO44XPU-U6HFEB3-K6A35SN-FSOCGS3-56SJX4M-KXVJXGS-LOAOCKI-KLJ3GQX";
        };
        "crius" = {
          id =
            "QQ6XDR3-I4DVVCN-KRR6V3X-4OTVYWY-CQLQFQ4-KBWQCXC-VVYJF7H-ZLPYSQC";
        };
        "mnemosyne" = {
          id =
            "TX4F2ST-NP3IDIQ-N4N5TCH-UHHNW66-G7YLNN3-BIWFFDC-2THH32Z-LXLGDQC";
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
          devices = [ "kronos" "crius" "mnemosyne" ];
          ignorePerms = false;
        };
      };
    };
  };
}
