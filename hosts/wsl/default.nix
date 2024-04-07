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

      # Programs
      gnome.enable = false;
      vscodium.enable = false;
      syncthing.enable = false;
      firefox.enable = false;
      obsidian.enable = false;
      spotify.enable = false;
      bitwarden.enable = false;
      zotero.enable = false;
      discord.enable = false;      
      neovim.enable = true;
      alacritty.enable = false;
      tmux.enable = true;

      # WSL
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
        enable = false;
        loginServer = "";
        acceptRoutes = true;
      };
    }
  ];
}
