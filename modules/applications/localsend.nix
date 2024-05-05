{ config, pkgs, lib, ... }: {
  
  options = {
    localsend = {
      enable = lib.mkEnableOption {
        decription = "Enable Localsend";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.localsend.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [ localsend ];
    };
  };
}
