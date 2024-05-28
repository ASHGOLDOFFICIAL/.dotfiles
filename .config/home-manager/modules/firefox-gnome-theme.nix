{ config, lib, pkgs, ... }:

let
  cfg = config.custom.firefox-gnome-theme;
  firefox-gnome-theme = pkgs.callPackage ../firefox-gnome-theme.nix {};
in {
  options.custom.firefox-gnome-theme = {
    enable = lib.mkEnableOption "a GNOME theme for Firefox";
    profiles = lib.mkOption {
      default = [];
      description = "List of profile names for which to apply the theme.";
      example = [ "default" ];
      type = with lib.types; listOf str;
    };
    theme = lib.mkOption {
      default = "default";
      description = "Set the colors used in the theme.";
      example = "maia";
      type = lib.types.enum [ "default" "maia" ];
    };
  };

  config = lib.mkIf cfg.enable {
    programs.firefox.profiles = builtins.listToAttrs (map (name: {
      name = name;
      value = let
        importColorchemes = theme: lib.optionalString (theme != "default") ''
          @import "${firefox-gnome-theme}/theme/colors/light-${theme}.css";
          @import "${firefox-gnome-theme}/theme/colors/dark-${theme}.css";
        '';
      in {
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
          "browser.theme.dark-private-windows" = lib.mkDefault false;
          "browser.uidensity" = lib.mkDefault 0;
          "widget.gtk.rounded-bottom-corners.enabled" = lib.mkDefault true;
        };

        userChrome = lib.mkBefore (''
          @import "${firefox-gnome-theme}/userChrome.css";
        '' + importColorchemes cfg.theme);

        userContent = lib.mkBefore (''
          @import "${firefox-gnome-theme}/userContent.css";
        '' + importColorchemes cfg.theme);
      };
    }) cfg.profiles);
  };
}
