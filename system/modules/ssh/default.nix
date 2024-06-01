{ ... }:
# SSH setup
{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "yes";
    ports  = [ 22 ];
  };
}
