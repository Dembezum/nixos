{...}:
{
  programs.plasma6.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";
  services.xserver.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
}

