{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ alacritty tab-rs ];
  home.file = {
    ".config/alacritty/alacritty.yml".source = ./alacritty.yml;
    ".config/fish/fish_variables".source = ./fish_variables;
    ".config/starship.toml".source = ./starship.toml;
  };
  # Configure fish shell
  programs.fish.enable = true;
  programs.fish.plugins = [{
    name = "z";
    src = pkgs.fetchFromGitHub {
      owner = "jethrokuan";
      repo = "z";
      rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
      sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
    };
  }];
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  # Configure comfy dev environments with lorri
  # See: https://github.com/nix-community/lorri
  # services.lorri.enable = true;
  # Configure direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  # optional for nix flakes support in home-manager 21.11, not required in home-manager unstable or 22.05
  programs.direnv.nix-direnv.enableFlakes = true;
}
