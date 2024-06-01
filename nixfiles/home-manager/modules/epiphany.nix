{ config, lib, pkgs, ... }@args:

let
  cfg = config.custom.gnome;
in {
  options.custom.gnome.epiphany = lib.mkEnableOption "Epiphany config options";

  config = lib.mkIf cfg.epiphany {
    dconf.settings = let
      inherit (lib.gvariant)
        mkDictionaryEntry
        mkVariant;
    in {
      "org/gnome/epiphany" = {
        default-search-engine = "Google";
        use-google-search-suggestions = true;
        search-engine-providers = let
          createSearchProvider = { url, bang, name }: [
            (mkDictionaryEntry "url" (mkVariant url))
            (mkDictionaryEntry "bang" (mkVariant bang))
            (mkDictionaryEntry "name" (mkVariant name))
          ];
        in [
          (createSearchProvider {
            url = "https://duckduckgo.com/?q=%s&t=epiphany";
            bang = "!d";
            name = "DuckDuckGo";
          })
          (createSearchProvider {
            url = "https://www.google.com/search?q=%s";
            bang = "!g";
            name = "Google";
          })
          (createSearchProvider {
            url = "https://search.nixos.org/packages?channel=unstable&type=packages&query=%s";
            bang = "!np";
            name = "Nix Packages";
          })
          (createSearchProvider {
            url = "https://search.nixos.org/options?channel=unstable&type=packages&query=%s";
            bang = "!no";
            name = "NixOS Options";
          })
        ];
      };
      "org/gnome/epiphany/state" = {
        download-dir = "${config.home.homeDirectory}/Downloads/Browser";
      };
      "org/gnome/epiphany/sync" = {
        sync-passwords-enabled = true;
      };
      "org/gnome/epiphany/web" = {
        enable-spell-checking = true;
        language = [ "en-US" "en-GB" "ru-RU" ];
      };
    };
  };
}
