{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
# Networking tools
      wget
      git
      dnsutils
      nmap
      socat
      screen
      tcpdump
      sshfs-fuse

# System utilities
      neofetch
      ncdu
      tree
      which
      pciutils
      usbutils
      lm_sensors
      xclip
      fzf
      eza
      bat

# Process management
      htop
      ripgrep
      btop
      parted
      gptfdisk
      fuse

# Disk management
      sdparm
      hdparm

# Archive management
      gnutar
      unzip
      zip

# Termianl Stuff
      kitty
      tmux

# Text manipulation / editing
      vim

# System recovery and management
      efibootmgr # EFI boot manager
      efivar # EFI variable manager

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

