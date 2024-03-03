{ config, pkgs, lib, userSettings, systemSettings, ...}:

{
# Enable virtualization support
  virtualisation.libvirtd.enable = true;

# Automatically start the libvirt daemon
  services.libvirtd.enable = true;

  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      allowedBridges = ["virbr0"];
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };

  home.packages = with pkgs; [
    virt-manager
      virt-viewer
      win-spice
      win-virtio
      spice
      spice-gtk
      spice-protocol
      qemu_kvm
      libvirt

  ];

}
