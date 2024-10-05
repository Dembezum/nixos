{ pkgs }:

pkgs.mkShell {
  name = "JS/TS devShell";

  buildInputs = with pkgs; [
    # A bunch of tools for JavaScript and TypeScript development
    nodejs
    yarn
    typescript
    eslint
  ];

  shellHook = ''
    echo "JavaScript and TypeScript development shell environment loaded."
  '';
}
