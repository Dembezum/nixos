{ pkgs, ... }: {
# Ensure Program is installed by declaring it in the home.packages
  home.packages = with pkgs; [
    kitty
  ];

# Kitty configuration
  programs.kitty.enable = true;
  programs.kitty.font.name = "JetBrainsMonoNL Regular";
  programs.kitty.theme = "Kurayami";

# Adjusting keybindings to include font size changes
  programs.kitty.keybindings = {
    "ctrl+shift+enter" = "new_window";
    "ctrl+shift+c" = "copy_to_clipboard";
    "ctrl+shift+v" = "paste_from_clipboard";
    "ctrl+shift+plus" = "increase_font_size";
    "ctrl+shift+minus" = "decrease_font_size";
  };
               }

