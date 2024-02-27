{ pkgs, ... }: {
  # Ensure Program is installed by declaring it in the home.packages
  home.packages = with pkgs; [
    neovim
  ];

  # Program specific configuration
  programs.neovim = {
    enable = true;
    extraConfig = ''
    
    '' # Config goes there ^
  };
}
