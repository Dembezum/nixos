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
  version = "555.58.02";
  sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
  sha256_aarch64 = "sha256-wb20isMrRg8PeQBU96lWJzBMkjfySAUaqt4EgZnhyF8=";
  openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
  settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
  persistencedSha256 = "sha256-a1D7ZZmcKFWfPjjH1REqPM5j/YLWKnbkP9qfRyIyxAw=";
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
