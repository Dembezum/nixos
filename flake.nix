{
  description = "Zums flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim-flake.url = "github:dembezum/nixvim";
  };

  outputs = { nixpkgs, home-manager, nix-flatpak, ... }@inputs:
    let
      # --- SYSTEM CONFIGURATION ---
      systemSettings = {
        system = "x86_64-linux";
        hostname = "nixkia";
        profile = "nixkia";
        systemstate = "23.11";
      };

      # --- USER CONFIGURATION ---
      userSettings = {
        username = "nixkia";
        name = "nixkia";
        editor = "nvim";
        term = "xterm-256color";
        terminal = "foot";
        browser = "firefox";
        video = "feh";
        image = "mpv";
        homestate = "23.11";
      };

      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
      inherit (nixpkgs) lib;

    in {
      homeConfigurations = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./profiles/${systemSettings.profile}/home.nix
            #              inputs.nixvim.homeManagerModules.nixvim
          ];
          extraSpecialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
        };
      };

      nixosConfigurations = {
        system = lib.nixosSystem {
          inherit (systemSettings) system;
          modules = [
            ./profiles/${systemSettings.profile}/configuration.nix
            nix-flatpak.nixosModules.nix-flatpak
          ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
        };
      };

      # --- DEVELOPMENT ENVIRONMENTS ---

      devShells = {
        ${systemSettings.system} = {
          cdev =
            import ./modules/user/shells/cdev/default.nix { inherit pkgs; };
          pydev =
            import ./modules/user/shells/pydev/default.nix { inherit pkgs; };
          jsdev =
            import ./modules/user/shells/jsdev/default.nix { inherit pkgs; };
          javadev =
            import ./modules/user/shells/jsdev/default.nix { inherit pkgs; };
          godev =
            import ./modules/user/shells/godev/default.nix { inherit pkgs; };
          zigdev =
            import ./modules/user/shells/zigdev/default.nix { inherit pkgs; };
        };
      };

    };
}
