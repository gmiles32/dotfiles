{ config, pkgs, lib, ... }: {
  
  options = {
    quickemu = {
      enable = lib.mkEnableOption {
        decription = "Enable Quickemu";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.quickemu.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [ quickemu ];
    };
  };
}
