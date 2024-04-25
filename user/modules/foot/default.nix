{ ... }: 

{
  programs.foot.enable = true;

  programs.foot.settings = {
# -- MAIN --
    main = {
      term = "xterm-256color";
      font = "JetBrainsMono Nerd Font:size=14";
      dpi-aware = "no";
    };
    tweak = {
      overflowing-glyphs = "yes";
    };
# -- SCROLLBACK --
    scrollback = {
      lines = 10000;
    };
# -- MOUSE --
    mouse = {
      hide-when-typing = "no";
    };
# -- KEYBINDS --
    key-bindings = {
      font-reset = "Control+0";
      font-increase = "Control+k";
      font-decrease = "Control+j";
      scrollback-up-page = "Shift+Page_Up";
      scrollback-down-page = "Shift+Page_Down";
    };
    mouse-bindings = {
      scrollback-up-mouse = "BTN_BACK";
      scrollback-down-mouse = "BTN_FORWARD";
      select-begin = "BTN_LEFT";
      select-begin-block = "Control+BTN_LEFT";
      select-extend = "BTN_RIGHT";
      };
    colors = {
        # Catppuccin mocha
        alpha = "0.9";
        foreground = "cdd6f4"; # Text
        background = "1E1D2F"; # Base
        regular0 = "45475a"; # Surface 1
        regular1 = "f38ba8"; # red
        regular2 = "a6e3a1"; # green
        regular3 = "f9e2af"; # yellow
        regular4 = "89b4fa"; # blue
        regular5 = "f5c2e7"; # pink
        regular6 = "94e2d5"; # teal
        regular7 = "bac2de"; # Subtext 1
        bright0 = "585b70"; # Surface 2
        bright1 = "f38ba8"; # red
        bright2 = "a6e3a1"; # green
        bright3 = "f9e2af"; # yellow
        bright4 = "89b4fa"; # blue
        bright5 = "f5c2e7"; # pink
        bright6 = "94e2d5"; # teal
        bright7 = "a6adc8"; # Subtext 0

        # Catppuccin macchiato
        # alpha = "1.0";
        # foreground = "cad3f5"; # Text
        # background = "24273a"; # Base
        # regular0 = "494d64"; # Surface 1
        # regular1 = "ed8796"; # red
        # regular2 = "a6da95"; # green
        # regular3 = "eed49f"; # yellow
        # regular4 = "8aadf4"; # blue
        # regular5 = "f5bde6"; # pink
        # regular6 = "8bd5ca"; # teal
        # regular7 = "b8c0e0"; # Subtext 1
        # bright0 = "5b6078"; # Surface 2
        # bright1 = "ed8796"; # red
        # bright2 = "a6da95"; # green
        # bright3 = "eed49f"; # yellow
        # bright4 = "8aadf4"; # blue
        # bright5 = "f5bde6"; # pink
        # bright6 = "8bd5ca"; # teal
        # bright7 = "a5adcb"; # Subtext 0


        # Rosé Pine
        # alpha = "0.8";
        # background = "191724";
        # foreground = "e0def4";
        # regular0 = "26233a"; # black (Overlay)
        # regular1 = "eb6f92"; # red (Love)
        # regular2 = "31748f"; # green (Pine)
        # regular3 = "f6c177"; # yellow (Gold)
        # regular4 = "9ccfd8"; # blue (Foam)
        # regular5 = "c4a7e7"; # magenta (Iris)
        # regular6 = "ebbcba"; # cyan (Rose)
        # regular7 = "e0def4"; # white (Text)
        # bright0 = "6e6a86"; # bright black (Overlay)
        # bright1 = "eb6f92"; # bright red (Love)
        # bright2 = "31748f"; # bright green (Pine)
        # bright3 = "f6c177"; # bright yellow (Gold)
        # bright4 = "9ccfd8"; # bright blue (Foam)
        # bright5 = "c4a7e7"; # bright magenta (Iris)
        # bright6 = "ebbcba"; # bright cyan (Rose)
        # bright7 = "e0def4"; # bright white (Text)
      };


  };

}

