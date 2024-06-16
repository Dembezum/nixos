{ lib, pkgs, config, ... }:

{
services.xserver.videoDrivers = [ "nvidia" ];
hardware.nvidia = {
  open = false;
  nvidiaSettings = true;
  modesetting.enable = false;
  powerManagement.enable = true;
  powerManagement.finegrained = false; 
  forceFullCompositionPipeline = false;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
#  package = config.boot.kernelPackages.nvidiaPackages.beta;
};

# Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

environment.sessionVariables = {
# Force the use of the EGL Wayland platform
  "EGL_PLATFORM" = "wayland";
# Enable the NVIDIA Wayland EGL backend
  "XDG_SESSION_TYPE" = "wayland";
};
}
