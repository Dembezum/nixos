{ inputs, config, pkgs, ... }:
# modules/hyprland/default.nix
# Fully configured Hyprland enviornment

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
     ./waybar.nix
      ../foot
  ];

# -- COLORSCHEME --
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

# -- PACKAGES TO INSTALL --
  home.packages = with pkgs; [
    hyprland
      pcmanfm
      rofi-wayland
      libnotify
      mako
      swww
# -- DISPLAY --
      drm_info
      wdisplays
      wlroots
      wlr-randr
      wl-clipboard
      grimblast
# -- AUDIO --
      pamixer
      playerctl
      pavucontrol
  ];

# -- MAKO (Notifications) --
  services.mako = {
    enable = true;
    backgroundColor = "#${config.colorScheme.palette.base00}";
    borderColor = "#${config.colorScheme.palette.base0E}";
    textColor = "#${config.colorScheme.palette.base05}";
    defaultTimeout = 5000;
    borderRadius = 5;
    borderSize = 2;
    layer = "overlay";
  };

# -- HYPRLAND CONFIGURATION --
  wayland.windowManager.hyprland = {
    enable = true;
    settings = with config.colorScheme.palette; {
      "$mainMod" = "SUPER";

# -- GENERAL --
      general = {
        gaps_in = 10;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgb(${base0E}) rgb(${base0E}) 45deg";
        "col.inactive_border" = "rgb(${base00})";
        layout = "master";
        allow_tearing = false;
      };

# -- ENV VARIABLES --
      env = [
        "XCURSOR_SIZE,24"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];

# -- MASTER LAYOUT --
      master = {
        new_is_master = false;
      };

# -- DWINDLE LAYOUT --
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
        force_split = 2;
      };

# -- GESTURES --
      gestures = {
        workspace_swipe = "on";
      };

# -- DECORATION --
      decoration = {
        rounding = 10;
        blur = {
          size = 3;
          passes = 1;
        };
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        dim_special = 0;
        "col.shadow" = "rgba(${base00}ee)";
      };

# -- ANIMATIONS --
      animations = {
        bezier = [
          "windowBezier, 0.05, 0.9, 0.1, 1.05"
        ];
        animation = [
          "windows, 1, 7, windowBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
        ];
      };

# -- KEYBOARD --
      input = {
        kb_layout = "dk";
        kb_options = "";
        follow_mouse = 1;

# -- MOUSE --
        touchpad = {
          natural_scroll = "no";
          disable_while_typing = false;
        };

        sensitivity = 0;
        accel_profile = "flat";
      };

# -- MISC --
      misc = {
        disable_hyprland_logo = false;
        disable_splash_rendering = true;
        force_default_wallpaper = 1;
      };

# -- KEYBINDS --
      bind = [
        ",PRINT, exec, grimblast --freeze copy area"
          "$mainMod, E, exec, pcmanfm"
          "$mainMod, X, exec, foot -e tmux"
          "$mainMod SHIFT, B, exec, firefox"
          "$mainMod SHIFT, Q, killactive,"
          "$mainMod SHIFT, C, exit,"
          "$mainMod, F, togglefloating,"
          "$mainMod, R, exec, rofi -show drun"
          "$mainMod SHIFT, T, pseudo, # dwindle"
          "$mainMod, J, togglesplit,"
          "$mainMod, M, fullscreen"

# Focus
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod SHIFT, Space, exec, move_window special"

# Move windows
          "$mainMod SHIFT, H, movewindow, l"
          "$mainMod SHIFT, L, movewindow, r"
          "$mainMod SHIFT, K, movewindow, u"
          "$mainMod SHIFT, J, movewindow, d"

# Scroll through workspaces
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
# Resize windos
          "$mainMod, l, resizeactive, 50 0"
          "$mainMod, h, resizeactive, -50 0"
          "$mainMod, k, resizeactive, 0 -50"
          "$mainMod, j, resizeactive, 0 50"

# Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

# Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

# Audio Keys
          ",XF86AudioRaiseVolume,exec,pamixer -i 2"
          ",XF86AudioLowerVolume, exec, pamixer -d 2"
          ",XF86AudioMute, exec, pamixer -t"

# Media keys
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPrev, exec, playerctl previous"
      ];
    };

# -- MONITOR CONFIGURATION --
    extraConfig = ''
      monitor=Unknown-3,3440x1440@100,3440x0,1
      monitor=Unknown-4,1920x1080@60,2360x0,1,transform,3

# -- WORKING CONFIG --
#monitor=DP-3,3440x1440@100,3440x0,1
#monitor=DP-5,1920x1080@60,2360x0,1,transform,3
#monitor=eDP-1,1920x1080@60,4240x1440,1
      '';
  };
}
