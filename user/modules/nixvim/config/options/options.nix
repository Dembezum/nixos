{ pkgs, ... }:
let
in {
  imports = [ ];
  wrapRc = true;
  enableMan = true;
  colorschemes.catppuccin = {
    enable = true;
    settings = { flavour = "mocha"; };
    # transparentBackground = true;
  };
  opts = {
    number = true; # Show line numbers
    relativenumber = true; # Show relative line numbers
    autoindent = true;
    smartindent = true;
    backspace = "indent,eol,start";
    cmdheight = 1;
    colorcolumn = "80";
    cursorline = true;
   # expandtab = true;
    updatetime = 100;
    foldenable = true;
    splitbelow = true;
    splitright = true;
    foldexpr = "nvim_treesitter#foldexpr()";
    foldlevel = 5;
    foldmethod = "expr";
    ignorecase = true;
    # laststatus = 3;
    mouse = "a";
    # pumheight = 0;
    shiftwidth = 4;
    showtabline = 1;
    signcolumn = "yes";
    # smartcase = true;
    tabstop = 4;
    termguicolors = true;
    # timeoutlen = 300;
    undofile = true;
    swapfile = false;
    # updatetime = 300;
    # wrap = false;
    # writebackup = true;
    clipboard = "unnamedplus";
    scrolloff = 999;
    virtualedit = "block";
    inccommand = "split";
  };

  # extraPlugins to add that are not availble in nixvim repo... u can configure them using lua....(which  i don't do)

  extraPlugins = with pkgs.vimPlugins; [
    neoformat
    vim-test
    vimux
    vim-quickrun
    vim-be-good
    neorg
    neorg-telescope
  ];
#  extraConfigLua = builtins.readFile ./config.lua;

  # extraConfigLuaPost =
  #   # lua
  #   ''
  #   '';

  autoCmd = [{
    event = [ "TermOpen" ];
    pattern = [ "*" ];
    command = "startinsert";
  }];
  # };
}
