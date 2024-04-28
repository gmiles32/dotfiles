{ config, pkgs, lib, ... }: {
  
  imports = [
    ./npm
  ];

  options.quartz.enable = lib.mkEnableOption "Enable Quartz.";

  config = lib.mkIf config.quartz.enable {
    home-manager.users.${config.user} = {
      home.packages = [ pkgs.npm.quartz pkgs.nodejs_21 ];
    };
  };
}
