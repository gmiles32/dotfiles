{ config, pkgs, lib, ... }: {
  
  config = {
    home-manager.users.${config.user} = {
      programs.bash = {
        enable = true;
        bashrcExtra = ''
          # Talosctl
          export TALOSCONFIG="/home/gabe/Projects/talos/talosconfig"

          # Kubectl
          export KUBECONFIG="/home/gabe/Projects/talos/kubeconfig"
          source <(kubectl completion bash)
        '';
      };
    };    
  };
}
