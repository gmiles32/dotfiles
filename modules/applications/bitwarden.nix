{ config, pkgs, lib, ... }: {
  
  options = {
    bitwarden = {
      enable = lib.mkEnableOption {
        description = "Enable Bitwarden";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.bitwarden.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [ bitwarden ];
    };
  };
}
