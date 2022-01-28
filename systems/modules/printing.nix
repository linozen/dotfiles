{ config, lib, pkgs, ... }:

{
  # Configure printing
  services.printing.enable = true;
  services.printing.browsing = true;
  services.printing.drivers = [ pkgs.gutenprint pkgs.splix ];
  services.system-config-printer.enable = true;
}
