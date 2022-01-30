{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;

    in {
      nixosConfigurations = {
        crius = lib.nixosSystem {
          inherit system;
          modules = [ ./systems/crius.nix ];
        };
        kronos = lib.nixosSystem {
          inherit system;
          modules = [ ./systems/kronos.nix ];
        };
        perses = lib.nixosSystem {
          inherit system;
          modules = [ ./systems/perses.nix ];
        };
      };

      homeManagerConfigurations = {
        lino-crius = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          stateVersion = "21.11";
          username = "lino";
          homeDirectory = "/home/lino";
          configuration = { imports = [ ./users/lino/crius.nix ]; };
        };
        lino-kronos = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          stateVersion = "21.11";
          username = "lino";
          homeDirectory = "/home/lino";
          configuration = { imports = [ ./users/lino/kronos.nix ]; };
        };
        lino-perses = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          stateVersion = "21.11";
          username = "lino";
          homeDirectory = "/home/lino";
          configuration = { imports = [ ./users/lino/perses.nix ]; };
        };
      };
    };
}
