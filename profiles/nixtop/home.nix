{ config, pkgs, userSettings, ... }:

{
# -- IMPORTS --
  imports = [
      ../../user/modules/tmux
      ../../user/modules/kitty
      ../../user/modules/foot
      ../../user/modules/shells
      ../../user/modules/neovim
      ../../user/modules/desktop
      ../../user/modules/hyprland
      ../../user/modules/minecraft
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

  home.stateVersion = userSettings.homestate;

# -- DEFAULT PACKAGES --
  home.packages = with pkgs; [
      firefox
      vesktop
      spotify
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

}
