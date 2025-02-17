{ cfg }:
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf cfg.enable {
    programs.plasma = {
      kwin.virtualDesktops = {
        names = [ "Background" "VLC" "Work 1" "Telegram" "Work 2" "Browser" ];
        rows = 1;
      };

      window-rules = let
        getDesktop = name: "Desktop_" + builtins.toString ((lib.lists.findFirstIndex
          (x: x == name)
          null
          config.programs.plasma.kwin.virtualDesktops.names) + 1);
      in [
        {
          description = "KeePassXC";
          match.window-class = {
            value = "keepassxc";
            type = "substring";
          };
          apply.desktops = {
            value = getDesktop "Background";
            apply = "force";
          };
        }

        {
          description = "nekoray";
          match.window-class = {
            value = "nekoray";
            type = "substring";
          };
          apply.desktops = {
            value = getDesktop "Background";
            apply = "force";
          };
        }

        {
          description = "qBittorrent";
          match.window-class = {
            value = "qbittorrent";
            type = "substring";
          };
          apply.desktops = {
            value = getDesktop "Background";
            apply = "force";
          };
        }

        {
          description = "Telegram Desktop";
          match.window-class = {
            value = "telegram";
            type = "substring";
          };
          apply.desktops = {
            value = getDesktop "Telegram";
            apply = "force";
          };
        }

        {
          description = "Intellij IDEA";
          match.window-class = {
            value = "intellij";
            type = "substring";
          };
          apply.desktops = {
            value = getDesktop "Work 1";
            apply = "force";
          };
        }

        {
          description = "Krita";
          match.window-class = {
            value = "krita";
            type = "substring";
          };
          apply.desktops = {
            value = getDesktop "Work 2";
            apply = "force";
          };
        }

        {
          description = "Firefox";
          match.window-class = {
            value = "firefox";
            type = "substring";
          };
          apply.desktops = {
            value = getDesktop "Browser";
          };
        }
      ];
    };
  };
}