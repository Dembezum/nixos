{ pkgs, ... }:

{
  # SSH setup
  environment.systemPackages = [ pkgs.opensshWithKerberos pkgs.openssh_gssapi ];


  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
    };
    ports = [ 22 ];
  };
}
