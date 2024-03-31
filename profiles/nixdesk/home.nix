{ config, pkgs, userSettings, ... }:

{
# -- IMPORTS --
  imports = [
      ../../user/modules/tmux
      ../../user/modules/kitty
      ../../user/modules/foot
      ../../user/modules/neovim
      ../../user/modules/shells
      ../../user/modules/hyprland
      ../../user/modules/minecraft
      ../../user/modules/desktop
  ];

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
