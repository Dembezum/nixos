{ inputs, config, pkgs, userSettings, systemSettings, ... }:
# Nixdesk
{
  # -- IMPORTS --
  imports = [
    ../../modules/user/gtk
    ../../modules/user/foot
    ../../modules/user/zsh
    ../../modules/user/tmux
    #    ../../modules/user/kitty
    #      ../../modules/user/neovim
    #      ../../modules/user/shells
    ../../modules/user/hyprland
    ../../modules/user/desktop
  ];

  # -- USER SETTINGS --
  home = {
    inherit (userSettings) username;
    homeDirectory = "/home/${userSettings.username}";
    packages = [
      pkgs.cliphist
      pkgs.obs-studio
      pkgs.headsetcontrol
      pkgs.easyeffects
      pkgs.inkscape
      pkgs.drawio
      pkgs.lazygit
      pkgs.jq
      pkgs.sops
      #    pkgs.#darktable
      pkgs.rawtherapee
      pkgs.imagemagick
      pkgs.nautilus
      pkgs.ventoy
      pkgs.bambu-studio
      pkgs.prusa-slicer
      pkgs.freecad
      inputs.nixvim-flake.packages.${systemSettings.system}.default
    ];
    sessionVariables = {
      TERM = userSettings.term;
      TERMINAL = userSettings.terminal;
      BROWSER = userSettings.browser;
      EDITOR = userSettings.editor;
      VIDEO = userSettings.video;
      IMAGE = userSettings.image;
    };

  };
  programs.home-manager.enable = true;

  # Package configuration
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = true;
    };
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
