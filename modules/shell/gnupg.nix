{ config, pkgs, lib, ... }: {

  options = {
    gnupg = {
      enable = lib.mkEnableOption {
        description = "Enable GnuPG";
        default = false;
      };
    };
  };

  config = {
    services.pcscd.enable = true;
    home-manager.users.${config.user} = {
      services.gpg-agent = {
        enable = true;
        pinentryFlavor = "curses";
        enableSshSupport = true;
      };
    };
  };
}
