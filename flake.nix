{
  description = "A NixOS configuration flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
    let 
    system = "x86_64-linux";

  pkgs = nixpkgs.legacyPackages.${system};
  lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ];
      };
    };
    homeConfigurations = {
      nixtop = home-manager.lib.homeManagerConfiguration { 
        inherit pkgs;
        modules = [ ./user/users/nixtop/home.nix ];
      };
    };
  };
}

