{ config, pkgs, lib, ... }:
{

  imports = [
    ./themes
  ];

  options = {
    gnome = {
      enable = lib.mkEnableOption {
        description = "Enable gnome";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gnome.enable) {
    services.xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
    };
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = with pkgs.gnome; [
      eog         # image viewer
      epiphany    # web browser
      gedit       # text editor
      simple-scan # document scanner
      totem       # video player
      yelp        # help viewer
      #evince      # document viewer
      file-roller # archive manager
      geary       # email client
      seahorse    # password manager

      # these should be self explanatory
      gnome-calculator 
      gnome-calendar 
      gnome-characters 
      gnome-clocks 
      gnome-contacts
      gnome-font-viewer 
      gnome-logs 
      gnome-maps 
      gnome-music 
      gnome-screenshot
      gnome-system-monitor 
      gnome-weather
      #gnome-tour # This one is just pkgs
      #gnome-disk-utility 
      pkgs.gnome-connections
    ];
    programs.dconf.enable = true;

    # Set profile picture
    system.activationScripts.script.text = ''
      cp /etc/nixos/hosts/common/profile.jpg /var/lib/AccountsService/icons/${config.user}
    '';

    home-manager.users.${config.user} = {
      home.packages = (with pkgs; [
        gnome.gnome-tweaks
        ( whitesur-icon-theme.override {
          themeVariants = [ "default" ];
          boldPanelIcons = true;
          alternativeIcons = true;
        })
        bibata-cursors
        roboto
        #jetbrains-mono
        ( google-fonts.override {fonts = [ "Signika" "Open Sans" ]; })
        ( nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        ]) ++ (with pkgs.gnomeExtensions; [
          blur-my-shell
          caffeine
        ]) ++ (with pkgs.themes; [
          ( whitesur-gtk-theme.override { 
            altVariants = [ "normal" ]; 
            themeVariants = [ "default" ];
            opacityVariants = [ "solid" ];
            iconVariant =  "simple";
            nautilusStyle = "mojave";  
          })
       ]);

      gtk = {
        enable = true;
        iconTheme = {
          name = "WhiteSur-dark";
        };
        theme = {
          name = "WhiteSur-Dark-solid";
        };
        cursorTheme = {
          name = "Bibata-Modern-Classic";
        };
        gtk3.extraConfig = {
          Settings = ''
            gtk-application-prefer-dark-theme=1
          '';
        };
        gtk4.extraConfig = {
          Settings = ''
            gtk-application-prefer-dark-theme=1
          '';
        };
      };
    
      # Set default theme
      home.sessionVariables.GTK_THEME = "WhiteSur-Dark-solid";

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
        "org/gnome/shell" = {
          favorite-apps = [
            "firefox.desktop"
            "org.gnome.Console.desktop"
            "org.gnome.Nautilus.desktop"
            "code.desktop"
            "obsidian.desktop"
            "zotero.desktop"
            "discord.desktop"
            "spotify.desktop"
            "bitwarden.desktop"
          ];
        };
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            "user-theme@gnome-shell-extensions.gcampax.github.com"
            "blur-my-shell@aunetx"
            "caffeine@patapon.info"
            "Tiling-Assistant@Leleat"
          ];
        };
        "org/gnome/desktop/interface" = {
          document-font-name = "Roboto 11";
          font-name = "Roboto 11";
          monospace-font-name= "JetBrainsMono Nerd Font Medium Italic 10";
        };
        "org/gnome/desktop/wm/preferences" = {
          titlebar-font = "Roboto 11";
        };
        "org/gnome/desktop/wm/keybindings" = {
          move-to-workspace-1 = [ "<Shift><Super>1" ];
          move-to-workspace-2 = [ "<Shift><Super>2" ];
          move-to-workspace-3 = [ "<Shift><Super>3" ];
          move-to-workspace-4 = [ "<Shift><Super>4" ];
          switch-to-workspace-1 = [ "<Super>1" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
        }; 
        "org/gnome/shell/keybindings" = {
          switch-to-application-1 = [ "<Super>9" ];
          switch-to-application-2 = [ "<Super>8" ];
          switch-to-application-3 = [ "<Super>7" ];
          switch-to-application-4 = [ "<Super>6" ];
        };
      };
    };
  };
}

