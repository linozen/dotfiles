{ config, lib, pkgs, ... }:

{
  # Configure GnuPG
  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ./gpg/fsfe_erik.key;
        trust = "marginal";
      }
      {
        source = ./gpg/fsfe_heiki.key;
        trust = "marginal";
      }
      {
        source = ./gpg/fsfe_jackie.key;
        trust = "marginal";
      }
      {
        source = ./gpg/fsfe_linda.key;
        trust = "marginal";
      }
      {
        source = ./gpg/fsfe_max.key;
        trust = "marginal";
      }
      {
        source = ./gpg/fsfe_mk.key;
        trust = "marginal";
      }
      {
        source = ./gpg/fsfe_patrick.key;
        trust = "marginal";
      }
    ];
  };
}
