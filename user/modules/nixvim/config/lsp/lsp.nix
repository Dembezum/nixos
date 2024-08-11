{ pkgs, ... }: {

  plugins = {
    clangd-extensions.enable = true;
    trouble.enable = true;
    lsp-format.enable = true;

    lsp = {
      enable = true;
      servers = {
        nixd = {
          enable = true;
          autostart = true;
        };
        jsonls.enable = true;
        lua-ls.enable = true;
        zls.enable = true;
        pyright.enable = true;
        bashls.enable = true;
        clangd = {
          enable = true;
          autostart = true;
        };
      };

      keymaps.lspBuf = {
        "gd" = "definition";
        "gD" = "references";
        "gt" = "type_definition";
        "gi" = "implementation";
        "K" = "hover";
      };
    };
  };
}

