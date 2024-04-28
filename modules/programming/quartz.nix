{ config, pkgs, lib, ... }: {

  options.quartz.enable = lib.mkEnableOption "Enable Quartz.";

  config = lib.mkIf config.quartz.enable {
    home-manager.users.${config.user} = {
      home.packages = (with npm; [
        quartz
      ]);
    };
  };
}
