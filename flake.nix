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

          modules = [ ./configuration.nix ];
        };
      };

      homeManagerConfigurations = {
        lino = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          stateVersion = "21.11";
          username = "lino";
          homeDirectory = "/home/lino";
          configuration = { imports = [ ./users/lino/home.nix ]; };
        };
      };
    };
}
