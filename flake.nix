# Flake.nix

{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let 
# --- SYSTEM CONFIGURATION ---
    systemSettings = {
      system = "x86_64-linux";
      hostname = "nixtop";
      profile = "nixtop";
    };

# --- USER CONFIGURATION ---
    userSettings = rec {
      username = "nixtop";
      name = "Nixtop";
      editor = "nvim";
      term ="kitty";
      browser = "firefox";
    };

    pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    lib = nixpkgs.lib;

in {
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ (./. +
          "/profiles"+("/"+systemSettings.profile)+"/home.nix") ];# load home.nix from selected PROFILE ];
          extraSpecialArgs = {
            inherit systemSettings;
            inherit userSettings;
          };
      };
    };
    nixosConfigurations = {
      system = lib.nixosSystem {
        system = systemSettings.system;
        modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/configuration.nix") ]; # load configuration.nix from selected PROFILE
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
       };
      };
    };

# --- DEVELOPMENT ENVIRONMENTS ---
    devShells.x86_64-linux.default =
      pkgs.mkShell
      {
        nativeBuildInputs = with pkgs; [
          stdenv
            neovim
            nodejs_21
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

