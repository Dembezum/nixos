{ pkgs, config, ... }:

{
hardware.nvidia = {
  modesetting.enable = true;
  powerManagement.enable = false;
  powerManagement.finegrained = false; 
  open = false;
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.beta;
  forceFullCompositionPipeline = true;
};

# Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
