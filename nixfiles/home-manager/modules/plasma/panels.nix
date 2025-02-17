{ cfg }:
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf cfg.enable {
    programs.plasma.panels = [
      {
        floating = true;
        height = 64;
        hiding = "dodgewindows";
        location = "bottom";

        widgets = [
          "org.kde.plasma.panelspacer"

          { kickoff.sortAlphabetically = true; }

          {
            iconTasks = {
              launchers = [
                "applications:steam.desktop"
                "applications:firefox.desktop"
                "applications:org.telegram.desktop.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:org.keepassxc.KeePassXC.desktop"
                "applications:vlc.desktop"
                "applications:subtitleedit.desktop"
                "applications:org.es_de.frontend.desktop"
              ];
              appearance.iconSpacing = "large";
              behavior = {
                showTasks = {
                  onlyInCurrentScreen = false;
                  onlyInCurrentDesktop = false;
                  onlyInCurrentActivity = false;
                  onlyMinimized = false;
                };
                unhideOnAttentionNeeded = false;
                sortingMethod = "byDesktop";
              };
            };
          }

          "org.kde.plasma.panelspacer"
        ];
      }

      {
        height = 24;
        location = "top";

        widgets = [
          "org.kde.plasma.pager"
          "org.kde.plasma.panelspacer"

          {
            digitalClock = {
              date = {
                format.custom = "ddd, MMM d  ";
                position = "besideTime";
              };
              time.format = "12h";
            };
          }

          "org.kde.plasma.panelspacer"

          {
            systemTray = {
              icons.spacing = "large";
              items = {
                shown = [ "org.kde.plasma.battery" ];
                hidden = [
                  "org.kde.plasma.volume"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.clipboard"
                ];
              };
            };
          }
        ];
      }
    ];
  };
}