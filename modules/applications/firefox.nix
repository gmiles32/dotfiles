{ config, pkgs, lib, ... }:
{
  options = {
    firefox = {
      enable = lib.mkEnableOption {
        description = "Enable firefox";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.firefox.enable) {
    home-manager.users.${config.user} = {

      programs.firefox = {
        enable = true;
        policies = {
          DisplayBookmarksToolbar = "never";
          DisplayMenuBar = "default-off";
          SearchBar = "unified";
          ExtensionSettings = with builtins;
            let extension = shortId: uuid: {
              name = uuid;
                value = {
                install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
                installation_mode = "normal_installed";
              };
            };
            in listToAttrs [
              (extension "ublock-origin" "uBlock0@raymondhill.net")
              (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
              (extension "raindropio" "jid0-adyhmvsP91nUO8pRv0Mn2VKeB84@jetpack")
              (extension "Tabliss" "extension@tabliss.io")
              (extension "OneTab" "extension@one-tab.com")
            ];
        };
        profiles.default = {
          id = 0;
          name = "Default";
          settings = {
            # Enable HTTPS-Only Mode
            "dom.security.https_only_mode" = true;
            "dom.security.https_only_mode_ever_enabled" = true;

            # Disable all sorts of telemetry
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "browser.ping-centre.telemetry" = false;
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.hybridContent.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.updatePing.enabled" = false;

            # As well as Firefox 'experiments'
            "experiments.activeExperiment" = false;
            "experiments.enabled" = false;
            "experiments.supported" = false;
            "network.allow-experiments" = false;

            # Disable saving passwords
            "signon.rememberSignons" = false;
            "signon.autofillForms" = false;
            "signon.formlessCapture.enabled" = false;
            "network.auth.subresource-http-auth-allow" = 1;

            # Disable Pocket
            "extensions.pocket.enabled" = false;

            # Disable Firefox View
            "browser.tabs.firefox-view" = false;
            "browser.tabs.firefox-view-next" = false;

            # For themes
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          };          
        };
      };
    };
  };
}
