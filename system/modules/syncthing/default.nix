{ userSettings, ... }:

#  -- SYNCTHING --
{
services = {
  syncthing = {
    enable = true;
    user = userSettings.username;
    relay = {
        enable = false;
      };
    dataDir = "/home/${userSettings.username}/Sync";
    configDir = "/home/${userSettings.username}/.config/syncthing";
#    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = false;     # overrides any folders added or deleted through the WebUI
    settings = {
#      devices = {
#        "device1" = { id = "DEVICE-ID-GOES-HERE"; };
#        "device2" = { id = "DEVICE-ID-GOES-HERE"; };
#      };
      folders = {
        "Sync" = {         # Name of folder in Syncthing, also the folder ID
          path = "/home/${userSettings.username}/Sync";    # Which folder to add to Syncthing
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

