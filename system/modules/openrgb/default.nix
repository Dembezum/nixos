{ pkgs, lib, ... }:
let
  no-rgb = pkgs.writeScriptBin "no-rgb" ''
    #!/bin/sh
    # Get the device number for the NVIDIA RTX 2080 Super MSI Edition
    TARGET_DEVICE=$(${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices | grep -i "nvidia rtx 2080 super" | cut -d':' -f1 | tr -d ' ')

    if [ -n "$TARGET_DEVICE" ]; then
      # Disable RGB for the specific device
      ${pkgs.openrgb}/bin/openrgb --noautoconnect --device $TARGET_DEVICE --mode static --color 000000
    else
      echo "NVIDIA RTX 2080 Super MSI Edition not found!"
    fi
  '';
in {
  config = {
    services.udev.packages = [ pkgs.openrgb ];
    boot.kernelModules = [ "i2c-dev" ];
    hardware.i2c.enable = true;

    systemd.services.no-rgb = {
      description = "no-rgb";
      serviceConfig = {
        ExecStart = "${no-rgb}/bin/no-rgb";
        Type = "oneshot";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}

