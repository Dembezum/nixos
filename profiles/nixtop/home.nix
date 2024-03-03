{ config, pkgs, lib, userSettings, ... }:

{
  programs.home-manager.enable = true;
  home.file = { };
  home.stateVersion = "23.11";

# Package configuration
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = with pkgs; [
    firefox
      vesktop
      spotify

  ];


  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  home.sessionVariables = {
    editor = userSettings.editor;
  };

  xdg.enable = true;
  xdg.userDirs = {
    extraConfig = {
      XDG_GAME_DIR = "${config.home.homeDirectory}/Games";
    };
  };

}
