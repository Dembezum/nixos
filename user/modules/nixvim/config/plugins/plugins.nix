{
  plugins = {
    friendly-snippets.enable = true;
    surround.enable = true;
    lualine.enable = true;
    which-key.enable = true;
    bufferline.enable = true;

    ## startup theme...
    alpha = {
      enable = true;
      theme = "startify";
      iconsEnabled = true;
    };

    vim-css-color.enable = true;
    notify.enable = true;

    nvim-colorizer.enable = true;

    telescope = {
      enable = true;
      extensions = {
        file-browser = { enable = true; };
        ui-select = { enable = true; };
      };
    };

    comment.enable = true;
    neo-tree.enable = true;
    twilight.enable = true;

    nvim-autopairs.enable = true;

    treesitter = {
      enable = true;
      nixGrammars = true;
      settings = { indent.enable = true; };
    };

    treesitter-context = {
      enable = true;
      settings = { max_lines = 2; };
    };
    markdown-preview = {
      enable = true;
      settings = {
        browser = "firefox";
        echo_preview_url = true;
        port = "6969";
        preview_options = {
          disable_filename = true;
          disable_sync_scroll = true;
          sync_scroll_type = "middle";
        };
        theme = "dark";
      };
    };
    indent-blankline = {
      enable = true;
      settings = {
        indent = {
          char = "│"; # "│" or "▎"
        };
        scope = {
          enabled = true;
          show_start = true;
        };
        exclude = {
          buftypes = [ "terminal" "nofile" ];
          filetypes = [
            "help"
            "alpha"
            "dashboard"
            "neo-tree"
            "Trouble"
            "trouble"
            "lazy"
            "mason"
            "notify"
            "toggleterm"
            "lazyterm"
          ];
        };
      };
    };
  };
}
