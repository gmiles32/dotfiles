{ config, pkgs, lib, ... }: {

  options = {
    alacritty = {
      enable = lib.mkEnableOption {
        description = "Enable Alacritty";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.alacritty.enable) {
    home-manager.users.${config.user} = {
      programs.alacritty = {
        enable = true;
        settings = {
          colors = {
            primary = {
              background = "#161616";
              foreground = "#f2f4f8";
            };  

            normal = {
              black = "#282828";
              red = "#ee5396";
              green = "#25be6a";
              yellow = "#08bdba";
              blue = "#78a9ff";
              magenta = "#be95ff";
              cyan = "#33b1ff";
              white = "#dfdfe0";
            };

            bright = {
              black = "#484848";
              red = "#f16da6";
              green = "#46c880";
              yellow = "#2dc7c4";
              blue = "#8cb6ff";
              magenta = "#c8a5ff";
              cyan = "#52bdff";
              white = "#e4e4e5";
            };

          };
        };
      };
    };
  };
}
