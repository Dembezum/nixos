{ pkgs }:

pkgs.mkShell {
  name = "Go devShell";

  buildInputs = with pkgs; [
    go
    gotools
    gopls
    golangci-lint
    delve
    gofumpt

  ];

  shellHook = ''
    echo "Go development shell environment loaded."
  '';
}
