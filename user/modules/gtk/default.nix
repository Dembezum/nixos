{ pkgs, ... }: 

{
  home = {
    packages = with pkgs; [
      dconf
        catppuccin-gtk
        dconf-editor
    ];
#    pointerCursor = {
#      name = "catppuccin-Mocha-Peach-cursors";
#      package = pkgs.catppuccin-cursors.mochaPeach;
#      size = 24;
#      gtk.enable = true;
#      x11.enable = true;
#    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.catppuccin-cursors.mochaSapphire;
      name = "catppuccin-mocha-sapphire-cursors";
    };
    theme = {
      name = "Catppuccin-Mocha-Standard-Lavender-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["lavender"];
        size = "standard";
        tweaks = [];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Mocha-Standard-Lavender-Dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
