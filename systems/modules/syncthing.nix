{ config, lib, pkgs, ... }:

{
  services = {
    syncthing = {
      enable = true;
      user = "lino";
      # TODO Insert key.pem for full declarativeness
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
        "syno" = {
          id =
            "S2YI6L6-NHBTDAD-NFB4NXB-ATJZQ6V-ACWWLC4-Y2A66XR-RT3JN3R-YMR52AU";
        };
      };
      folders = {
        "org" = {
          path = "/home/lino/Exocortex/org";
          devices = [ "kronos" "crius" "syno" ];
          ignorePerms = false;
        };
        "pdfs" = {
          path = "/home/lino/Exocortex/pdfs";
          devices = [ "kronos" "crius" "syno" ];
          ignorePerms = false;
        };
        "reading" = {
          path = "/home/lino/Exocortex/reading";
          devices = [ "kronos" "crius" "syno" "mnemosyne" ];
          ignorePerms = false;
        };
        "gtimelog" = {
          path = "/home/lino/.local/share/gtimelog";
          devices = [ "kronos" "crius" "syno" ];
          ignorePerms = false;
        };
        "music" = {
          path = "/home/lino/Music";
          devices = [ "kronos" "crius" "syno" ];
          ignorePerms = false;
        };
      };
    };
  };
}
