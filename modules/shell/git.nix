{ config, pkgs, lib, ... }:

let home-packages = config.home-manager.users.${config.user}.home.packages;

in {
  
  options = {
    gitName = lib.mkOption {
      type = lib.types.str;
      description = "Name for git commits";
    };
    gitEmail = lib.mkOption {
      type = lib.types.str;
      description = "Email for git commits";
    };
  };

  config = {
    home-manager.users.root.programs.git = {
      enable = true;
    };

    home-manager.users.${config.user} = {
      programs.git = {
        enable = true;
        userName = config.gitName;
        userEmail = config.gitEmail;
      };
    };
  };
}
