{ pkgs, ... }: {
  # Ensure Program is installed by declaring it in the home.packages
  home.packages = with pkgs; [ kitty ];

  # Kitty configuration
  programs = {
    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMonoNL Regular";
        size = 11;
      };
      theme = "Catppuccin-Mocha";
      settings = {
        confirm_os_window_close = 0;
        scrollback_lines = 10000;
        enable_audio_bell = false;
      };

      # Adjusting keybindings to include font size changes
      keybindings = {
        "ctrl+shift+enter" = "new_window";
        "ctrl+shift+c" = "copy_to_clipboard";
        "ctrl+shift+v" = "paste_from_clipboard";
        "ctrl+shift+plus" = "increase_font_size";
        "ctrl+shift+minus" = "decrease_font_size";
      };
    };
  };

}
