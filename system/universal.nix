{ config, pkgs ... }:

{
  environment.systemPackages = with pkgs; [
    wget
      vim
      htop
      git
      neofetch
      zip
      unzip
      ripgrep
      eza
      fzf
      dnsutils
      nmap
      gnutar
      tree
      which
      pciutils
      usbutils
      lm_sensors
      btop
      htop
      git

      ];
}
