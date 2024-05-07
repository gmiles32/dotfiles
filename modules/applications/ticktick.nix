{ config, pkgs, lib, ... }: {
  
  options = {
    ticktick = {
      enable = lib.mkEnableOption {
        decription = "Enable TickTick";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.ticktick.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [ ticktick ];
    };
  };
}
