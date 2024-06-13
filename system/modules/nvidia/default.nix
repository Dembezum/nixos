{ pkgs, config, ... }:

{
services.xserver.videoDrivers = ["nvidia"];
hardware.nvidia = {
  open = false;
  nvidiaSettings = true;
  modesetting.enable = true;
  powerManagement.enable = false;
  powerManagement.finegrained = false; 
  forceFullCompositionPipeline = false;
  package = config.boot.kernelPackages.nvidiaPackages.beta;
};

# Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
