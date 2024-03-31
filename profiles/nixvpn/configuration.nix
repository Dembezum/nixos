{ systemSettings, userSettings, pkgs, ... }:

# --- VPN CONFIGURATION ---
{
  imports = [
      ../../universal.nix
      ../../user/modules/tmux
      ../../user/modules/shells
      ./hardware-configuration.nix
      ../../system/modules/networking
      ../../system/modules/ssh
      ../../system/modules/nix-settings
  ];

  environment.systemPackages = [ 
    pkgs.tailscale 
    pkgs.neovim
  ];

  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
        set cc=80
        set number
        set relativenumber
        set hlsearch = false
        set incsearch = true
        set swapfile = false
        set cursorline = true
        set virtualedit = "block"
        endif
        '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ ctrlp ];
      };
    };
  };

  services.tailscale.enable = true;

  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";

    after = [ "network-pre.target" "tailscale.service" ];
    wants = [ "network-pre.target" "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.Type = "oneshot";

    script = with pkgs; ''
# wait for tailscaled to settle
      sleep 2

# check if we are already authenticated to tailscale
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
          fi

# otherwise authenticate with tailscale
          ${tailscale}/bin/tailscale up -authkey tskey-auth-kN5XLi5odW11CNTRL-akQPxKDChxfRxgsu53qsxfbPDDBYTWYFW
          '';

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    users.users.${userSettings.username} = {
      isNormalUser = true;
      description = userSettings.name;
      extraGroups = [ "plugdev" "networkmanager" "wheel" ];
      uid = 1000;
    };

    system.stateVersion = systemSettings.systemstate;
  };

}
