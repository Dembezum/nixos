{ inputs, config, pkgs, userSettings, ... }:

{
# -- IMPORTS --
  imports = [
    inputs.nix-colors.homeManagerModules.default
      ../../user/modules/tmux
      ../../user/modules/kitty
      ../../user/modules/foot
      ../../user/modules/neovim
      ../../user/modules/shells
      ../../user/modules/hyprland
      ../../user/modules/minecraft
      ../../user/modules/desktop
  ];

# -- COLORSCHEMES --
colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

services.mako = {
    enable = true;
    backgroundColor = "#${config.colorScheme.colors.base01}";
    borderColor = "#${config.colorScheme.colors.base0E}";
    borderRadius = 5;
    borderSize = 2;
    textColor = "#${config.colorScheme.colors.base04}";
    layer = "overlay";
  };

# -- USER SETTINGS --
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;
  programs.home-manager.enable = true;

# Package configuration
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

# -- DEFAULT PACKAGES --
  home.packages = with pkgs; [
      lazygit
  ];

# -- VARIABLES --
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };

# -- XDG CONFIGURATION --
  xdg.enable = true;
  xdg.userDirs = {
    extraConfig = {
      XDG_GAME_DIR = "${config.home.homeDirectory}/Games";
    };
  };

  home.stateVersion = userSettings.homestate;
}
