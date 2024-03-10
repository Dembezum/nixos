{ ... }:
# SSH setup
{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
    ports  = [ 22 ];
  };
}
