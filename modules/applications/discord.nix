{ config, pkgs, lib, ... }: {

  options = {
    discord = {
      enable = lib.mkEnableOption {
        description = "Enable Discord.";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.discord.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [ discord ];
    };
  };
}
