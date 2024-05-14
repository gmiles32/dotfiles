{ config, pkgs, lib, ... }: {

  config = {
    # Install generic fish system-wide
    programs.fish.enable = true;
    
    # Install custom fish for user
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [ fzf fd bat ];
      programs.fish = {
        # General settings
        enable = true;

        plugins = [
          { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
          { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
          { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
          { name = "tide"; src = pkgs.fishPlugins.tide.src; }
        ];
      };
    };
  };
}
