{ config, inputs, pkgs, userSettings, systemSettings, ... }:
# Nixkia 
{
  # -- IMPORTS --
  imports = [
    ../../modules/user/gtk
    ../../modules/user/foot
    ../../modules/user/zsh
    ../../modules/user/tmux
    ../../modules/user/kitty
    ../../modules/user/hyprland
    ../../modules/user/desktop
    ../../modules/user/kde
  ];

  # -- USER SETTINGS --
  home = {
    username = userSettings.username;
    homeDirectory = "/home/${userSettings.username}";

    packages = [
      pkgs.headsetcontrol
      pkgs.easyeffects
      #      pkgs.inkscape
      pkgs.drawio
      pkgs.lazygit
      pkgs.mono
      pkgs.jq
      pkgs.rawtherapee
      pkgs.imagemagick
      pkgs.nautilus
      pkgs.ventoy
      inputs.nixvim-flake.packages.${systemSettings.system}.default
    ];
  };

  programs.home-manager.enable = true;

  # Package configuration
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # -- DEFAULT PACKAGES --

  # -- VARIABLES --
  home.sessionVariables = {
    TERM = userSettings.term;
    TERMINAL = userSettings.terminal;
    BROWSER = userSettings.browser;
    EDITOR = userSettings.editor;
    VIDEO = userSettings.video;
    IMAGE = userSettings.image;
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
    extraConfig = { XDG_GAME_DIR = "${config.home.homeDirectory}/Games"; };
  };
  home.stateVersion = userSettings.homestate;
}
