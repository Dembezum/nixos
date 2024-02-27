{
  description = "My first flake";

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
          modules = [ ./system/modules ];
        };
      };
      homeConfigurations = {
        nixtop = home-manager.lib.homeManagerConfiguration { 
          inherit pkgs;
          modules = [
            ./user/modules/gnome
            ./user/modules/neovim
            ./user/modules/normie
            ./user/modules/shells
            # Add any other user modules or configurations here
          ];
          users = {
            nixtop = ./user/users/nixtop;
            # Add any other user configurations here
          };
        };
      };
    };
}

