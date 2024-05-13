{ config, pkgs, lib, ... }: {

  config = {
    home-manager.users.${config.user} = {
      programs.zsh = {
        # General settings
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        # History settings
        history.size = 10000;
        history.path = "${config.xdg.dataHome}/zsh/history";

      };
    };    
  };
}
