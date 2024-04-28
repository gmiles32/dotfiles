{ ... }: {
  imports = [
    ./python.nix
    ./kubernetes.nix
    ./ansible.nix
    ./quartz.nix
  ];

}
