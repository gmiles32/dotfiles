{ config, lib, pkgs, ... }: {

  home-manager.users.${config.user} = {
    home.packages = (with pkgs; [
      ( nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ]);
  };
}
