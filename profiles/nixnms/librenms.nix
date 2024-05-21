{ config, pkgs, ... }:

{
  services.librenms = {
    enable = true;
    database = {
      host = "localhost";
      port = 3306;
      username = "nixdesk";
      passwordFile = "/pass.pass";
    };
  };

