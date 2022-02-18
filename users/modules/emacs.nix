{ config, lib, pkgs, ... }:

{
  # Define Emacs overlay
  nixpkgs.overlays = [
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/emacs-overlay.git";
      ref = "master";
      rev = "7b8d3f12dc35a1dbf93a2a6be30d9e6b157ba17e";
    }))
  ];

  # Install Emacs with natively compiled backend using overlay:
  # https://gist.github.com/mjlbach/179cf58e1b6f5afcb9a99d4aaf54f549
  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtkGcc;
    extraPackages = (epkgs: [
      # Needed for terminal emulation inside Emacs
      epkgs.vterm
      # Needed for reading mails inside Emacs
      pkgs.mu
    ]);
  };

  # Make Emacs client work correctly
  xsession.enable = true;
  services.emacs.enable = true;
  systemd.user.services.emacs.Unit = {
    After = [ "graphical-session-pre.target" ];
    PartOf = [ "graphical-session.target" ];
  };

  # Install related packages
  home.packages = with pkgs; [
    # General
    fd
    gnutls
    imagemagick
    (ripgrep.override { withPCRE2 = true; })
    sqlite
    zstd
    # Dictionaries & Grammar
    (aspellWithDicts (dicts: with dicts; [ de en en-computers en-science ]))
    jdk
    # LaTeX
    texlive.combined.scheme-full
    # Language Servers
    nodejs
    nodePackages.js-beautify
    nodePackages.vscode-langservers-extracted
    nodePackages.bash-language-server
    nodePackages.pyright
    html-tidy
    # Formatters
    nixfmt
    nodePackages.prettier
    # Cosmetics
    emacs-all-the-icons-fonts
    python3Minimal
    python39Packages.pywal
  ];
}
