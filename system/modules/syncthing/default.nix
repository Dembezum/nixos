{ systemSettings, ... }:

#  -- SYNCTHING --
{
services = {
  syncthing = {
    enable = true;
    user = systemSettings.username;
    dataDir = "/home/${systemSettings.username}/Sync";
    configDir = "/home/${systemSettings.username}/.config/syncthing";
#    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = true;     # overrides any folders added or deleted through the WebUI
    settings = {
#      devices = {
#        "device1" = { id = "DEVICE-ID-GOES-HERE"; };
#        "device2" = { id = "DEVICE-ID-GOES-HERE"; };
#      };
      folders = {
        "Sync" = {         # Name of folder in Syncthing, also the folder ID
          path = "/home/${systemSettings.username}/Sync";    # Which folder to add to Syncthing
          #devices = [ "device1" "device2" ];      # Which devices to share the folder with
        };
      };
    };
  };
};

# -- SYNCTHING WEBUI --
services.syncthing.settings.gui = {
    user = "admin";
    password = "admin";
};

  }

