{ config, lib, pkgs, ... }: {
  
  options = {
    tailscale = {
      enable = lib.mkEnableOption {
        description = "Enable Tailscale";
        default = false;
      };

      authKeyFile = lib.mkOption {
        description = "Authentication Key path for Tailscale";
        type = lib.types.str;
        default = "";
      };

      loginServer = lib.mkOption {
        description = "Login server to use for authentication with Tailscale";
        type = lib.types.str;
        default = "";
      };
  
      acceptRoutes = lib.mkOption {
        description = "Accept any advertised routes";
        type = lib.types.bool;
        default = false;
      };
    };    
  };

  config = lib.mkIf (config.tailscale.enable) {

    systemd.services.tailscale-autoconnect = {
      description = "Automatic connection to Tailscale";

      # make sure tailscale is running before trying to connect to tailscale
      after = ["network-pre.target" "tailscale.service"];
      wants = ["network-pre.target" "tailscale.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig.Type = "oneshot";

      script = with pkgs; ''
        # wait for tailscaled to settle
        sleep 2

        # check if we are already authenticated to tailscale
        status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
        # if status is not null, then we are already authenticated
        echo "tailscale status: $status"
        if [ "$status" != "NeedsLogin" ]; then
            exit 0
        fi

        # otherwise authenticate with tailscale
        # timeout after 10 seconds to avoid hanging the boot process
        ${coreutils}/bin/timeout 10 ${tailscale}/bin/tailscale up \
          ${lib.optionalString (config.tailscale.loginServer != "") "--login-server=${config.tailscale.loginServer}"} \
          --authkey=$(cat "${config.tailscale.authKeyFile}")

        # we have to proceed in two steps because some options are only available
        # after authentication
        ${coreutils}/bin/timeout 10 ${tailscale}/bin/tailscale up \
          ${lib.optionalString (config.tailscale.loginServer != "") "--login-server=${config.tailscale.loginServer}"} \
          ${lib.optionalString (config.tailscale.acceptRoutes) "--accept-routes"}
      '';
    };

    networking.firewall = {
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };

    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };

    environment.persistence = {
      "/persist".directories = ["/var/lib/tailscale"];
    };
  };
}
