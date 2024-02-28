{ config, pkgs, ... }: {
  # Ensure Program is installed by declaring it in the home.packages
  home.packages = with pkgs; [
    neovim
  ];

  # Program specific configuration
  programs.kitty = {
    enable = true;
    font = "Fira Code";
    fontSize = 12;
    colors = "catppuccin";
    

    extraConfig = ''
    
    '' # Config goes there ^
  };
}
