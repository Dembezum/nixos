{ pkgs, ... }: 

{
  home = {
    packages = with pkgs; [
      dconf
      catppuccin-gtk
      dconf-editor
    ];
    pointerCursor = {
      name = "catppuccin-mocha-peach-cursors";
      package = pkgs.catppuccin-cursors.mochaPeach;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-lavender-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "standard";
        variant = "mocha";
      };
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        '';
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Orchis-Dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}

