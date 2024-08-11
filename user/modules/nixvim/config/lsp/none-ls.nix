{
  plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    sources = {
      diagnostics = {
        golangci_lint.enable = true;
        ktlint.enable = true;
        statix.enable = true;
      };
      formatting = {
        nixfmt.enable = true;
        markdownlint.enable = true;
        clang_format.enable = true;
        stylua.enable = true;
        black.enable = true;
        fantomas.enable = true;
        gleam_format.enable = true;
        gofmt.enable = true;
        goimports.enable = true;
        shellharden.enable = true;
        shfmt.enable = true;
      };
    };
  };
}
