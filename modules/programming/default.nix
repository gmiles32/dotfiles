{ ... }: {
  imports = [
    ./python.nix
    ./kubernetes.nix
    ./ansible.nix
    ./npm
  ];

  home-manager.users.${config.user} = {
    home.packages = (with npm; [
      quartz
    ]);
  };

}
