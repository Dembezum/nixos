{ lib, pkgs, config, ... }:

{
services.xserver.videoDrivers = [ "nvidia" ];
hardware.nvidia = {
  open = false;
  nvidiaSettings = true;
  modesetting.enable = true;
  powerManagement.enable = false;
  powerManagement.finegrained = false; 
  forceFullCompositionPipeline = false;
#  package = config.boot.kernelPackages.nvidiaPackages.stable;
#  package = config.boot.kernelPackages.nvidiaPackages.beta;
};

hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
  version = "555.58";

   sha256_64bit = "sha256-bXvcXkg2kQZuCNKRZM5QoTaTjF4l2TtrsKUvyicj5ew=";
    sha256_aarch64 = "sha256-7XswQwW1iFP4ji5mbRQ6PVEhD4SGWpjUJe1o8zoXYRE=";
    openSha256 = "sha256-hEAmFISMuXm8tbsrB+WiUcEFuSGRNZ37aKWvf0WJ2/c=";
    settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
    persistencedSha256 = "sha256-lyYxDuGDTMdGxX3CaiWUh1IQuQlkI2hPEs5LI20vEVw=";
};


# Enable OpenGL
hardware.graphics = {
    enable = true;
  };
#  hardware.opengl = {
#    enable = true;
#    driSupport = true;
#    driSupport32Bit = true;
#  };
}
