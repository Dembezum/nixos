{ pkgs, config, lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.kernelModules = [ "nvidia" "kvm-amd" "nfs"];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "nfs" "ntfs" "vfat" "xfs" ];
  boot.kernelPackages = pkgs.linuxPackages_zen;

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/f8e3ca98-d2be-4429-9953-ab4bd973bda5";
    fsType = "ext4";
    options = [ "nofail"  ];
  };
  fileSystems."/mnt/nvme0n1" = {
    device = "/dev/disk/by-uuid/7243029d-09a7-4948-bc26-e4c8196a8673";
    fsType = "ext4";
    options = [ "nofail" ];
  };
  fileSystems."/" =
  { device = "/dev/disk/by-uuid/38b391bf-ffcb-46a0-be81-dd0eea1bcd92";
    fsType = "ext4";
  };
  fileSystems."/boot" =
  { device = "/dev/disk/by-uuid/DC70-63F7";
    fsType = "vfat";
  };
#  fileSystems."/mnt/nas/Homelab" = {
#    device = "10.0.20.102:/mnt/Pool1/Homelab";
#    fsType = "nfs";
#  };
  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  systemd.enableEmergencyMode = false;
}
