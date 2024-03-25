{ pkgs, inputs, config, ... }: {

  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../../hosts/common/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${config.user}/.config/sops/age/keys.txt";
    secrets.user-password.neededForUsers = true;
    secrets.tailscale-key.neededForUsers = true;
  };
}
