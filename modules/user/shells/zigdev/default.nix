{ pkgs }:

pkgs.mkShell {
  name = "zigdev-shell";

  buildInputs = with pkgs; [
    # A bunch of good tools for Zig development
    zig
    llvm
    lld
    cmake
    ninja
    gdb
    lldb
    valgrind
    strace
    ltrace
    ccache
    git
    doxygen
  ];

  shellHook = ''
    echo "Zig development shell environment loaded."
  '';
}
