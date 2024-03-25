{ config, pkgs, lib, ... }: {
  
  config = {
    networking.networkmanager.enable = true;
    networking.useDHCP = lib.mkDefault true;
  };
}
