{ config, lib, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    forceFullCompositionPipeline = false;
package = config.boot.kernelPackages.nvidiaPackages.production;
    #    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #       version = "555.58.02";
    #    sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
    #    sha256_aarch64 = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
    #    openSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
    #    settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
    #    persistencedSha256 = lib.fakeSha256;
    #    };
    #  package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  hardware.graphics = { enable = true; };
}
