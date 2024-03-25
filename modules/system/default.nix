{ config, pkgs, lib, ... }: {
  
  imports = [
    ./user.nix
    ./printing.nix
    ./timezone.nix
    ./sops.nix
    ./tailscale.nix
  ];

  config = {
    system.stateVersion = config.home-manager.users.${config.user}.home.stateVersion;
  };
}
