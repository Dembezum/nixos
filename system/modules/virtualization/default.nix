{ pkgs, ...}:

{
  virtualisation.libvirtd.enable = true;

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
