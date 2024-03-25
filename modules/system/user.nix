{ config, pkgs, lib, ... }: {

  config = {

    # Allows us to declaritively set password
    users.mutableUsers = false;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${config.user} = {

      # Create a home directory for human user
      isNormalUser = true;
      description = config.fullName;
      # Automatically create a password to start
      hashedPasswordFile = config.sops.secrets.user-password.path;

      extraGroups = [
        "networkmanager"
        "wheel" # Sudo privileges
      ];

    };

    # Allow writing custom scripts outside of Nix
    # Probably shouldn't make this a habit
    #environment.localBinInPath = true;
  };
}
