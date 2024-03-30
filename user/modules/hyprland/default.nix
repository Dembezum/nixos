{ pkgs, ... }:
# modules/hyprland/default.nix

{

  home.packages = with pkgs; [
    gnome.gdm
      rofi-wayland
      libnotify
      dunst
      drm_info
      waybar
      swww
      wlroots
      wl-clipboard
      wdisplays
      wlr-randr
      xdg-desktop-portal-wlr
      grimblast
  ];

#  wayland.windowManager.hyprland = {
#    enable = true;
#    xwayland.enable = true;
#    settings = {
#      "$mod" = "SUPER";
#      bind =
#        [
#        "$mod SHIFT, B, exec, firefox"
#        "$mod SHIFT, Q, killactive"
#        "$mod X, exec, kitty"
#        ", Print, exec, grimblast copy area"
#        ];
#    };
#    extraConfig = ''
#      env = WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0;
#    '';
#  };

}
