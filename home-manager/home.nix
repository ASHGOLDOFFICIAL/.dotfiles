{ config, lib, pkgs, ... }@args:

{
  imports = [
    ./modules/gnome.nix
    ./modules/firefox-gnome-theme.nix
  ];

  custom = {
    gnome = {
      enable = true;
      epiphany = false;
    };
    firefox-gnome-theme = {
      enable = true;
      profiles = [ "default" ];
      theme = "maia";
    };
  };

  home = {
    homeDirectory = "/home/ashgoldofficial";
    stateVersion = "23.05";
    username = "ashgoldofficial";
  };

  programs = {
    firefox = {
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

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ];

      extraPackages = with pkgs; [
        clang-tools
        fd
        lua-language-server
        nil
        nodePackages.typescript-language-server
        python311Packages.python-lsp-server
        ripgrep
        rust-analyzer
        vscode-langservers-extracted
      ];
    };

    # thunderbird = let
    #   thunderbird-gnone-theme = pkgs.callPackage ./thunderbird-gnome-theme.nix {};
    # in {
    #   enable = true;
    #   profiles.default = {
    #     isDefault = true;
    #     settings = {
    #       "svg.context-properties.content.enabled" = true;
    #       "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    #     };
    #     userChrome = ''
    #       @import "${thunderbird-gnone-theme}/userChrome.css";
    #     '';
    #     userContent = ''
    #       @import "${thunderbird-gnone-theme}/userContent.css";
    #     '';
    #   };
    # };

    home-manager.enable = true;
  };
}
