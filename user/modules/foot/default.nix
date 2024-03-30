{ ... }: 

{
  programs.foot.enable = true;

  programs.foot.settings = {
# -- MAIN --
    main = {
      term = "xterm-256color";
      font = "JetBrainsMonoNerdFont-Regular:size=12";
      dpi-aware = "no";
    };
# -- SCROLLBACK --
    scroolback = {
      lines = 10000;
    };
# -- MOUSE --
    mouse = {
      hide-when-typing = "no";
    };

  };

}

