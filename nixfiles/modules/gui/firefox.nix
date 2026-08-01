{ config, pkgs, lib, ... }:

let
  cfg = config.custom.gui.firefox;
in {
  options.custom.gui.firefox = {
    enable = lib.mkEnableOption "Firefox web browser";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      languagePacks = [ "en-GB" "en-US" "ru" ];
      policies = {
        DisableFirefoxScreenshots = true;
        DisablePocket = lib.mkDefault true;
        DisableTelemetry = lib.mkDefault true;
        DontCheckDefaultBrowser = lib.mkDefault true;
        NoDefaultBookmarks = lib.mkDefault true;
        PictureInPicture = {
          Enabled = lib.mkDefault true;
          Locked = lib.mkDefault true;
        };
      };
      preferences = {
        "privacy.donottrackheader.enabled" = true;
        "privacy.globalprivacycontrol.enabled" = true;
      };
      preferencesStatus = "locked";
      autoConfig = ''
        lockPref("sidebar.verticalTabs", true)
      '';
    };
  };
}
