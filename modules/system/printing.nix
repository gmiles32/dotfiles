{ config, lib, pkgs, ... }: {
  
  config = {
    services.printing.enable = true;
    
    # Auto discover network printers
    services.avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
  };
}
