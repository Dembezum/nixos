{
  description = "A NixOS configuration with home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        hm = import home-manager {
          inherit pkgs;
        };
      in {
        nixosConfigurations = {
          myNixOS = flake-utils.lib.nixosSystem {

            nixosModules = {
                users-nixtop = ./user/users/nixtop;
              };

            inherit system;
            modules = with self.nixosModules; [
              ({ config = { nix.registry.nixpkgs.flake = nixpkgs; }; })
            # Global system files
            ./configuration.nix
            ./hardware-configuration.nix
            ({
             imports = [
            # System modules
             ./system/modules/bluetooth
             ./system/modules/firewall
             ./system/modules/fonts
             ./system/modules/networking
             ./system/modules/pipewire
             ./system/modules/power-mgmt
             ./system/modules/ssh
             ./system/modules/virtualization
             ./system/modules/x11
             ./system/region
            ];
             })
            ];
          };
        };
        config = {
          home-manager.users.nixtop = ./user/users/nixtop/home.nix;
          users.users.nixtop = {
          };
        };

      }
      );
}
