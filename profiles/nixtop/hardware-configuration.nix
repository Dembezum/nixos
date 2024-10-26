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
      kernelModules = [ "" ];
    };
    kernelModules = [ "kvm-amd" "nfs" ];
    extraModulePackages = [ ];
    supportedFilesystems = [ "nfs" "ntfs" "vfat" "xfs" ];
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "ipv6.disable=1"
      "i8042.nopnp=1"
    ];
  };

  fileSystems."/mnt/extra" = {
    device = "/dev/disk/by-uuid/a5cfa160-1852-4b98-9251-6ce1eeabc266";
    fsType = "ext4";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c323aad0-c457-4011-973e-131207cfaefc";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A8FB-D45B";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/71d22b87-f178-493d-afe6-5007c1e0a57a"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
