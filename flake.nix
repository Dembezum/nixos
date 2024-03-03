# Flake.nix

{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
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
        modules = [
          ./user/users/nixtop
        ];
      };
    };
    devShells.x86_64-linux.default =
      pkgs.mkShell
      {
        nativeBuildInputs = with pkgs; [
          pkgs.stdenv
            pkg-config
            xorg.libX11
            xorg.libXft
            fontconfig
            freetype
            gd
            gnumake
            stdenv
            gcc
        ];
        shellHook = ''
          echo "Shell is ready to go!" | ${pkgs.lolcat}/bin/lolcat
          export X11INC=${pkgs.xorg.libX11.dev}/include
          export X11LIB=${pkgs.xorg.libX11.out}/lib
          '';
      };

  };
}

