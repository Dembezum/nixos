{ config, pkgs, ... }:

# require public key authentication for better security
services.openssh = {
  enable = true;
  settings.PasswordAuthentication = true;
  settings.KbdInteractiveAuthentication = false;
  settings.PermitRootLogin = "no";
};
