{ inputs, globals, system, ... }:

inputs.nixpkgs.lib.nixosSystem {
  system = system;
  specialArgs = { inherit inputs; };
  modules = [
    globals
    inputs.home-manager.nixosModules.home-manager
    inputs.impermanence.nixosModules.impermanence
    inputs.wsl.nixosModules.wsl
    ../../modules  
    {
      networking.hostName = "wsl";

      # Pkgs configuration
      nixpkgs.hostPlatform = system;
      nixpkgs.config.allowUnfree = true;

      neovim.enable = true;
      quartz.enable = false;

      # WSL
      virtual = true;
      wsl = {
        enable = true;
        wslConf.automount.root = "/mnt";
        defaultUser = globals.user;
        startMenuLaunchers = true;
        nativeSystemd = true;
        wslConf.network.generateResolvConf = true; # Turn off if it breaks VPN
        interop.includePath =
          false; # Including Windows PATH will slow down Neovim command mode
      };

      # Keys
      gnupg.enable = false;

      # Networking
      services.openssh.enable = true;
      tailscale = {
        enable = true;
        loginServer = "";
        acceptRoutes = true;
      };
    }
  ];
}
