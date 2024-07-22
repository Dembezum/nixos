{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.gcc
    pkgs.cmake
    pkgs.make
    pkgs.autoconf
    pkgs.automake
    pkgs.libtool
    pkgs.pkg-config
    pkgs.openssl
    pkgs.python3
    pkgs.python3Packages.virtualenv
    pkgs.nodejs
    pkgs.npm
    pkgs.git
    pkgs.gnumake
    pkgs.bash
    pkgs.which
    pkgs.gnugrep
    pkgs.gnused
    pkgs.gawk
    pkgs.findutils
    pkgs.diffutils
    pkgs.unzip
    pkgs.zip
    pkgs.bzip2
    pkgs.gzip
  ];

  shellHook = ''
    echo "Environment loaded with common build tools."
  '';
}

