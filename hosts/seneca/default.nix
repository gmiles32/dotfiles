{ inputs, globals, system, ... }:

inputs.nixpkgs.lib.nixosSystem {
  system = system;
  specialArgs = { inherit inputs; };
  modules = [
    globals
    inputs.home-manager.nixosModules.home-manager
    inputs.impermanence.nixosModules.impermanence
    ../../modules
    ./hardware-configuration.nix
    {
      networking.hostName = "seneca";
             
      # Prefer balanced mode
      powerManagement.cpuFreqGovernor = "balanced";

      # Pkgs configuration
      nixpkgs.hostPlatform = system;
      nixpkgs.config.allowUnfree = true;
      
      # Programs
      gnome.enable = true;
      vscode.enable = true;
      syncthing.enable = true;
      firefox.enable = true;
      obsidian.enable = true;
      spotify.enable = true;
      bitwarden.enable = true;
      zotero.enable = true;
      discord.enable = true;
      neovim.enable = true;
      alacritty.enable = false;
      tmux.enable = true;    
      localsend.enable = false;
      quickemu.enable = true;
      ticktick.enable = false;

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
