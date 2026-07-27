{ lib, config, pkgs, ... }:

let
  cfg = config.custom.firefox;
in {
  options.custom.firefox.enable = lib.mkEnableOption "Firefox";

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";
      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        
        search = {
          default = "google";
          privateDefault = "ddg";
          force = true;

          engines = {
            "NixOS Options" = {
              urls = [{
                template = "https://search.nixos.org/options";
                params = [
                  { name = "channel"; value = "unstable"; }
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@no" ];
            };
            
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "channel"; value = "unstable"; }
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            
            "RetroAchievements" = {
              urls = [{
                template = "https://retroachievements.org/searchresults.php";
                params = [
                  { name = "s"; value = "{searchTerms}"; }
                  { name = "t"; value = "1"; }
                ];
              }];
              icon = "https://static.retroachievements.org/assets/images/favicon.webp";
              updateInterval = 30 * 24 * 60 * 60 * 1000; # every month
              definedAliases = [ "@ra" ];
            };
            
            "bing".metaData.hidden = true;
            "ddg".metaData.alias = "@d";
            "google".metaData.alias = "@g";
            "wikipedia".metaData.alias = "@w";
          };

          order = [ "ddg" "google" "NixOS Options" "Nix Packages" "wikipedia" ];
        };
      };
    };
  };
}
