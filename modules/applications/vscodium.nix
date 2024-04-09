{ config, pkgs, lib, ... }: {
  
  options = {
    vscodium = {
      enable = lib.mkEnableOption {
        description = "Enable VSCodium";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.vscodium.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        (vscode-with-extensions.override {
          vscode = vscodium;
          vscodeExtensions = with vscode-extensions; [
            pkief.material-icon-theme
            mikestead.dotenv
            jnoortheen.nix-ide
            ms-python.python
            nonylene.dark-molokai-theme
            redhat.vscode-yaml

            # Foam
            foam.foam-vscode
            esbenp.prettier-vscode
            yzhang.markdown-all-in-one
          ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            # Foam theme
            {
              name = "theme-gray-matter";
              publisher = "philipbe";
              version = "1.7.0";
              sha256 = "sha256-DXK+TzPkAWn/wD/PP4KooVdm0KJZPtd5wBQDHKQZzVQ=";
            }
            {
              name = "nightfox";
              publisher = "keifererikson";
              version = "0.0.14";
              sha256 = "sha256-EZGKJMc/N+0V+9U/k12tUbzgfCNzWhdrouXRi7QOdyY=";
            }
          ];
        })
      ];	
    };
  };
}