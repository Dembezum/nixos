{
  description = "Zums flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
# --- SYSTEM CONFIGURATION ---
    systemSettings = {
      system = "x86_64-linux";
      hostname = "nixtop";
      profile = "nixtop";
      systemstate = "23.11";
    };

# --- USER CONFIGURATION ---
  userSettings = {
    username = "nixtop";
    name = "nixtop";
    editor = "nvim";
    term = "foot";
    browser = "firefox";
    homestate = "23.11";
  };

  pkgs = nixpkgs.legacyPackages.${systemSettings.system};
  lib = nixpkgs.lib;

  in {
    nixosConfigurations = {
      system = lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          ./profiles/${systemSettings.profile}/configuration.nix
          {
            home-manager.users.${userSettings.username} = {
              imports = [ ./profiles/${systemSettings.profile}/home.nix ];
            };
          }
        home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
        };
      };
    };
  };
}

