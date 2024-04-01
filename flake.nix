# Flake.nix
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
    term ="foot";
    browser = "firefox";
    homestate = "23.11";
  };
  pkgs = nixpkgs.legacyPackages.${systemSettings.system};

# Lib
  lib = nixpkgs.lib;

  in {
  #  homeConfigurations = {
  #    user = home-manager.lib.homeManagerConfiguration {
  #      inherit pkgs;
  #      modules = [ profiles/${systemSettings.profile}/home.nix ];
  #      extraSpecialArgs = {
  #        inherit systemSettings;
  #        inherit userSettings;
  #        inherit inputs;
  #      };
  #    };
  #  };

    homeConfigurations = {
      ${systemSettings.username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${systemSettings.system};
        modules = [ profiles/${systemSettings.profile}/home.nix ];
        home = {
          username = systemSettings.username;
          homeDirectory = "/home/${systemSettings.username}";
          stateVersion = "systemstate";
        };
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
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
          inherit inputs;
        };
      };
    };

# --- DEVELOPMENT ENVIRONMENTS ---
    devShells.${systemSettings.system}.default =
      pkgs.mkShell
      {
        nativeBuildInputs = with pkgs; [
            stdenv
            cargo
            neovim
            binutils
            clang
            glibc
            nodejs
            pkg-config
            fontconfig
            freetype
            gnumake
            gcc
            gd
            ffmpeg
            python3Packages.pip
            xorg.libX11
            xorg.libXft
            xorg.libX11.dev
            xorg.libXinerama
            ];
        shellHook = ''
          clear
          echo -e "\033[1;32m###############################\033[0m"
          echo -e "\033[1;32m##  Development Enviornment  ##\033[0m"
          echo -e "\033[1;32m###############################\033[0m"
          echo ""
          echo -e "\033[1;36m[Nix:\033[0m $(lsb_release -s -d)"
          echo -e "\033[1;36m[Load Average:\033[0m $(cut -d ' ' -f 1-3 /proc/loadavg)"
          echo -e "\033[1;36m[Available Memory:\033[0m $(free -h | awk '/Mem/ {print $7}')"
          echo -e "\033[1;36m[CPU Usage:\033[0m $(top -bn1 | awk '/%Cpu/ {printf("%.2f%", $2 + $4)}')"
          echo ""
          export X11INC=${pkgs.xorg.libX11.dev}/include
          export X11LIB=${pkgs.xorg.libX11.out}/lib
          '';
      };

  };
}

