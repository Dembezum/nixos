{ pkgs, ... }: {
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
      efibootmgr
      efivar
      parted
      gptfdisk
      fuse
      sshfs-fuse
      socat
      screen
      tcpdump
      sdparm
      hdparm
      kitty
      xclip
      ncdu
      tmux
      ];

# Xdg portals
#  xdg.portal = {
#    enable = true;
#    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
#  };

# Show chnages in the system configuration
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff \
      /run/current-system "$systemConfig"
      '';
  };

}

