{ config, pkgs, lib, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

    home.packages = with pkgs; [
    lxappearance-gtk2
  ];


  home.username = "nixtop";
  home.homeDirectory = "/home/nixtop";

  home.file = { };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim.withNodeJs = true;

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
