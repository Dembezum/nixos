{ pkgs, config, lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd = {
      availableKernelModules = [
        "nvme" # NVMe support
        "xhci_pci" # USB 3.0 support
        "ahci" # AHCI SATA support
        "usb_storage" # USB storage support
        "usbhid" # USB Human Interface Devices support
        "sd_mod" # SCSI disk support
        "virtio" # Virtualization drivers support
      ];
      kernelModules = [ "nvidia" ];
    };
    kernelModules = [ "nvidia" "kvm-amd" "nfs" ];
    extraModulePackages = [ ];
    supportedFilesystems = [ "nfs" "ntfs" "vfat" "xfs" ];
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "nvidia.NVreg_EnableGpuFirmware=0"
      "ipv6.disable=1"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"

    ];
  };
  #  powerManagement.enable = true;
  #  powerManagement.cpuFreqGovernor = "schedutil";

  # File systems configuration
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/38b391bf-ffcb-46a0-be81-dd0eea1bcd92";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/DC70-63F7";
      fsType = "vfat";
    };
    "/mnt/gaming" = {
      device = "/dev/disk/by-uuid/8df61ac5-b00d-4f50-89db-4d4c8f79f6ff";
      fsType = "ext4";
      options = [ "nofail" ];
    };
    "/mnt/nvme1n1" = {
      device = "/dev/disk/by-uuid/ccfc50da-6901-4d05-90e2-b9acde86f802";
      fsType = "ext4";
      options = [ "nofail" ];
    };
    #    "/mnt/nvme0n1" = {
    #      device = "/dev/disk/by-uuid/7243029d-09a7-4948-bc26-e4c8196a8673";
    #      fsType = "ext4";
    #      options = [ "nofail" ];
    #    };
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  systemd.enableEmergencyMode = false;
}
