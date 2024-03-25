{ config, pkgs, lib, ... }: {

  options = {
    syncthing = {
      enable = lib.mkEnableOption {
        description = "Enable syncthing";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.syncthing.enable) {
    services.syncthing = {
      enable = true;
      user = config.user;
      dataDir = "/home/${config.user}/Sync";
      configDir = "/home/${config.user}/.config/syncthing";
      settings = {
        devices = {
          "proton" = { id = "PMNVVCG-2TO4SEZ-HL7YNXU-HOGZQLW-RGA6BAE-T7QNE4J-SRZB4PX-BXRHZAJ"; };
        };
      };
      overrideDevices = false;
      overrideFolders = false;
    };
  };
}
