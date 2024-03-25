{ config, lib, pkgs, ... }: {
  imports = [
    ./applications
    ./shell
    ./hardware
    ./system
    ./programming
    ./gui
  ];

  options = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of system";
    };
    fullName = lib.mkOption {
      type = lib.types.str;
      description = "Human readable name of user";
    }; 
  };

  config = let stateVersion = "23.11";
  in {
    nix = {
      extraOptions = ''
        experimental-features = nix-command flakes
        warn-dirty = false
      '';
    };
    
    # Basic commands 
    environment.systemPackages = with pkgs; [ git vim wget curl pinentry-curses just ];
    
    # Use system level packages
    home-manager.useGlobalPkgs = true;

    # Install packages to /etc/profiles instead ot ~/.nix-profile
    home-manager.useUserPackages = true;

    # Pin a state version to prevent warnings
    home-manager.users.${config.user}.home.stateVersion = stateVersion;
    home-manager.users.root.home.stateVersion = stateVersion;
    system.stateVersion = stateVersion;

    # Secrets
    tailscale.authKeyFile = config.sops.secrets.tailscale-key.path;
  };
}
