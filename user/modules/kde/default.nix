# Kde plasma module 
{ config, lib, pkgs, ... }:

services.xserver.enable = true;
services.xserver.displayManager.sddm.enable = true;
services.xserver.desktopManager.plasma5.enable = true;

  plasma-browser-integration
  konsole
  oxygen
];

