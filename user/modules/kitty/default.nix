{ config, pkgs, ... }: {
  # Ensure Program is installed by declaring it in the home.packages
  home.packages = with pkgs; [
    neovim
  ];

# Kitty configuration
programs.kitty.enable = true;
programs.kitty.font.name = "JetBrainsMono Nerd Font";
programs.kitty.theme = "Kurayami";
}
