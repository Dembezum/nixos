{ config, lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd"  "nfs"];
  boot.extraModulePackages = [ ];

  boot.supportedFilesystems = [ "nfs" "btrfs" "cifs" "f2fs" "jfs" "ntfs" "reiserfs" "vfat" "xfs" ];

  fileSystems."/mnt/extra" = {
    device = "/dev/disk/by-uuid/c2b0371a-ffbf-40ea-9a00-316407e76788";
    fsType = "ext4";
  };

  fileSystems."/" =
  { device = "/dev/disk/by-uuid/38b391bf-ffcb-46a0-be81-dd0eea1bcd92";
    fsType = "ext4";
  };

  fileSystems."/boot" =
  { device = "/dev/disk/by-uuid/DC70-63F7";
    fsType = "vfat";
  };

  fileSystems."/mnt/share" = {
  device = "192.168.1.4:/mnt/Pool1/iso";
  fsType = "nfs";
};

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
