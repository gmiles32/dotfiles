{ config, pkgs, lib, ... }: {
  
  options = {
    zotero = {
      enable = lib.mkEnableOption {
        description = "Enable Zotero";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.zotero.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [ zotero ];
    };
  };
}
