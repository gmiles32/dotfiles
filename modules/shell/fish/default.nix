{ config, pkgs, lib, ... }: {

  config = {
    # Install generic fish system-wide
    programs.fish.enable = true;
    
    # Install custom fish for user
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [ fd bat nix-your-shell ];
      programs.fzf = {
        enable = true;
        enableFishIntegration = true;
      };

      programs.fish = {
        # General settings
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
        '';

        plugins = [
          { name = "forgit"; src = pkgs.fishPlugins.forgit.src; }
          { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
          { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
          { name = "tide"; src = pkgs.fishPlugins.tide.src; }
        ];

        functions = {
          nix-shell = {
            description = "Start an interactive shell based on a Nix expression";
            body = '' nix-your-shell fish nix-shell -- $argv '';
          };
          nix = {
            description = "Reproducible and declarative configuration management";
            body = '' nix-your-shell fish nix -- $argv '';
          };
        #  fish_prompt = {
        #    description = "Write out main prompt";
        #    body = builtins.readFile ./functions/fish_prompt.fish;
        #  };
        #  fish_right_prompt = {
        #    description = "Write out right prompt";
        #    body = builtins.readFile ./functions/fish_right_prompt.fish;
        #  };
        };
      };
    };
  };
}
