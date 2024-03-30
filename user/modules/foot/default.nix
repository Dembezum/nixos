{ ... }: 

{
  programs.foot.enable = true;

  programs.foot.settings = {
# -- MAIN --
    main = {
      term = "xterm-256color";
      font = "JetBrainsMono Nerd Font:size=12";
      dpi-aware = "no";
    };
# -- SCROLLBACK --
    scrollback = {
      lines = 10000;
    };
# -- MOUSE --
    mouse = {
      hide-when-typing = "no";
    };

  };

}

