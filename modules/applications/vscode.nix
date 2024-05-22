{ config, pkgs, lib, ... }: {
  
  options = {
    vscode = {
      enable = lib.mkEnableOption {
        description = "Enable VSCodium";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.vscode.enable) {
    home-manager.users.${config.user} = {
      programs.vscode = {
        enable = true;
      };
    };
  };
}
