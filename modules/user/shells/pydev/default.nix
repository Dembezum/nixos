{ pkgs }:

pkgs.mkShell {
  name = "pydev shell";

  buildInputs = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.setuptools
    python3Packages.wheel
    python3Packages.pytest
    python3Packages.mypy
    python3Packages.virtualenv
    python3Packages.ipython
    python3Packages.jupyter
  ];

  shellHook = ''
    echo "Python development shell environment loaded."
  '';
}
