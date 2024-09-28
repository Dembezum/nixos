{ pkgs }:

pkgs.mkShell {
  name = "cdev-shell";

  buildInputs = with pkgs; [
    gtest
    cppcheck
    conan
    clang-tools
    lcov
    vcpkg
    vcpkg-tool
    codespell
    doxygen
    lm_sensors
    gcc
    clang
    cmake
    ninja
    autoconf
    automake
    libtool
    pkg-config
    gdb
    valgri
    strac
    ltrace
    ccache
    gdbgui
    git
    openssl
    zlib
    gtk3
    gtk4
    glib
    mesa
  ];

  shellHook = ''
    export CC=gcc
    export CXX=g++
    export PKG_CONFIG_PATH=${pkgs.gtk3.dev}/lib/pkgconfig:${pkgs.glib.dev}/lib/pkgconfig:$PKG_CONFIG_PATH
    echo "C/C++ development shell environment loaded."
  '';
}
