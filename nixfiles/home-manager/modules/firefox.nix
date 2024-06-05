{ lib, config, pkgs, ... }:

let
  cfg = config.custom.firefox;
in {
  options.custom.firefox.enable = lib.mkEnableOption "Firefox";

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        search = {
          default = "Google";
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
            "Bing".metaData.hidden = true;
            "DuckDuckGo".metaData.alias = "@d";
            "Google".metaData.alias = "@g";
            "Wikipedia".metaData.alias = "@w";
          };
          force = true;
          order = [ "DuckDuckGo" "Google" "NixOS Options" "Nix Packages" "Wikipedia" ];
          privateDefault = "DuckDuckGo";
        };
      };
    };
  };
}
