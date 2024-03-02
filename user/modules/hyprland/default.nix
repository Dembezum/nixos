{ config, pkgs, ... }:

{
# Xdg portals
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

# Neededc services 
  services = {
    xserver = {
      enable = true; 
      displayManager.gdm.enable = true;
    };
    gnome.gnome-keyring.enable = true;

# gnome stuff
    gnome.gnome-keyring.enable = true;

    programs = {
      dconf.enable = true;
      direnv.enable = true;
      hyprland = {
        enable = true; 
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      };
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [ 
          xfconf
          thunar-volman 
        ];
      };
    };

# Ensure desired packages are available in the user environment.
    home.packages = with pkgs; [
      gnome.gdm
    ];
  }
