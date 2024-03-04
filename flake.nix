# Flake.nix

{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, home-manager, ... }:
    let 
# --- SYSTEM CONFIGURATION ---
    systemSettings = {
      system = "x86_64-linux";
      hostname = "nixtop";
      profile = "nixtop";
    };

# --- USER CONFIGURATION ---
  userSettings = {
    username = "nixtop";
    name = "Nixtop";
    editor = "nvim";
    term ="kitty";
    browser = "firefox";
  };
  pkgs = nixpkgs.legacyPackages.${systemSettings.system};


# Lib
  lib = nixpkgs.lib;

  in {
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ profiles/${systemSettings.profile}/home.nix ];
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
    nixosConfigurations = {
      system = lib.nixosSystem {
        system = systemSettings.system;
        modules = [ profiles/${systemSettings.profile}/configuration.nix];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };

# --- DEVELOPMENT ENVIRONMENTS ---
    devShells.${systemSettings.system}.default =
      pkgs.mkShell
      {
        nativeBuildInputs = with pkgs; [
          stdenv
            nixd
            nil
            rnix-lsp
            neovim
            binutils
            clang
            glibc
            nodejs_21
            pkg-config
            fontconfig
            freetype
            gnumake
            stdenv
            gcc
            gd
            xorg.libX11
            xorg.libXft
        ];
        shellHook = ''
          echo -e '\033[0;36mHello Welcome To Your devShell\033[0m'
          export X11INC=${pkgs.xorg.libX11.dev}/include
          export X11LIB=${pkgs.xorg.libX11.out}/lib
          '';
      };

  };
}

