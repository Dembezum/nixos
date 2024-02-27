{ config, pkgs, ... }:
{
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  networking.firewall.enable = true;

};
