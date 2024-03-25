{ config, pkgs, lib, ... }: {

  config = {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [ ansible ];
    };
  };
}
