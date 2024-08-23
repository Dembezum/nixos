{ config, lib, pkgs, modulesPath, ... }:

{

  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    supportedFilesystems = [ "nfs" "ntfs" "vfat" "xfs" ];
    kernelPackages = pkgs.linuxPackages_zen;
    initrd.availableKernelModules =
      [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];

    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/6ed9ad29-3a6a-4434-af90-4d5cf9d2b9bc";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/3CA2-FE70";
      fsType = "vfat";
    };

    "/mnt/extrahdd" = {
      device = "/dev/disk/by-uuid/423198af-be61-4f36-b479-e98cb264015e";
      fsType = "ext4";
      options = [ "nofail" ];
    };

    "/mnt/mintroot" = {
      device = "/dev/disk/by-uuid/450c5670-9b89-4c6b-bbb1-14b2e3d18549";
      fsType = "ext4";
      options = [ "nofail" ];
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/f32378a7-c769-4086-b59d-a3613641c74b"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware; 
}
