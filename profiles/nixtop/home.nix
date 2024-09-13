{ config, pkgs, userSettings, ... }:
# Nixtop
{
# -- IMPORTS --
  imports = [
    ../../modules/user/gtk
      ../../modules/user/zsh
      ../../modules/user/tmux
      ../../modules/user/kitty
      ../../modules/user/neovim
      ../../modules/user/shells
      ../../modules/user/hyprland
      ../../modules/user/minecraft
      ../../modules/user/desktop
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

# -- PACKAGES --
  home.packages = with pkgs; [
      lazygit
      jq
      screenkey
      slop
      gnome.nautilus
  ];

# -- VARIABLES --
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };

# -- XDG USER CONFIGURATION --
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_GAME_DIR = "${config.home.homeDirectory}/Games";
    };
  };
  home.stateVersion = userSettings.homestate;
}
