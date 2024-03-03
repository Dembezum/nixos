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


# Lib
    lib = nixpkgs.lib;

    supportedSystems = [
       "x86_64-linux"
     ];


in {
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/home.nix") ];# load home.nix from selected PROFILE ];
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
          echo -e '\033[0;36mHello\033[0m'
          export X11INC=${pkgs.xorg.libX11.dev}/include
          export X11LIB=${pkgs.xorg.libX11.out}/lib
          '';
      };
  };
}

