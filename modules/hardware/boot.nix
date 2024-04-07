{ config, pkgs, lib, ... }: {
  
  config = lib.mkIf (!config.wsl.enable) {
    # Set latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;
    
    # Set boot options
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
