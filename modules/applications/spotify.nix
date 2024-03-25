{ config, pkgs, lib, ... }: {
  
  options = {
    spotify = {
      enable = lib.mkEnableOption {
        decription = "Enable Spotify";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.spotify.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [ spotify ];
    };
  };
}
