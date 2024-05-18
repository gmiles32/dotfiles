{ inputs, globals, system, ... }:

inputs.nixpkgs.lib.nixosSystem {
  system = system;
  specialArgs = { inherit inputs; };
  modules = [
    globals
    inputs.home-manager.nixosModules.home-manager
    inputs.impermanence.nixosModules.impermanence
    inputs.wsl.nixosModules.wsl
    inputs.vscode-server.nixosModules.default
    ../../modules  
    {
      networking.hostName = "wsl";

      # Pkgs configuration
      nixpkgs.hostPlatform = system;
      nixpkgs.config.allowUnfree = true;

      neovim.enable = true;
      quartz.enable = false;
      quickemu.enable = true;

      # WSL
      virtual = true;

      # For VScode
      programs.nix-ld.enable = true;
      services.vscode-server.enable = true;

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
      users.users."${globals.user}".openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhF8Tvv0s0VWvbgUlzPZ4jV5c0wd8EIHIUvI3+uwbbWlQa+gCkPS6xYgIc5bTANaimWIonqj1V291lhkOB0w6cI03tw9t+F0jhYxJIWJJcapz5gFSjS+IKzJoQQ5Zddxl7sb6t078JBRWdTd6mHdhWcoytDYfH+4s1JlRUvgfx/zV3BOV+oNhKU3yU6H1j4Jto9faZUA77AlmUrhaGx1LS2LEedA89aE1oiYV879g536wqPahdNDL2wPe4EnjYhU8iYQ/CQuSSe1//w0zhoyGPmHyO5255UAUo66bP5F1LOSF9EoTzX+Fr7ndxR2zQMcBnEHOHJHPAWaMGEMpdI8DhJBXOh3GXk/b2EcGST1O9kvNWRdRmUPKCy83/QILF2yNM13zWeoyKqedjQp1kxL2ZkuY7kvrHAiiNoZj1XcvxXk/V6Cwb4Ckx71tt3QGgB7G28g2H56eMAXOaJULKcCV6pqGYGlSoCmNYPXDXMRWFscO3zs9XsWUL1kGoT3SsVAU= gabri@zeno"
      ];
      tailscale = {
        enable = true;
        loginServer = "";
        acceptRoutes = true;
      };
    }
  ];
}
