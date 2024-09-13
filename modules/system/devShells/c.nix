{ pkgs, ... }:
{

# --- DEVELOPMENT SHELL ---
  devShells.x86_64-linux.c =
    pkgs.mkShell
    {
      nativeBuildInputs = with pkgs; [
        stdenv
          neovim
          nodejs_21
          pkg-config
          fontconfig
          freetype
          gnumake
          stdenv
          gcc
          gd
          xorg.libX11
          xorg.libXft
      ];
      shellHook = ''
        echo -e '\033[0;36mHello\033[0m'
        export X11INC=${pkgs.xorg.libX11.dev}/include
        export X11LIB=${pkgs.xorg.libX11.out}/lib
        '';
    };

}
