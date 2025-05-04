{ config, lib, pkgs, ... }:

let
  cfg = config.custom.plasma;
in {
  imports = [
    (import ./panels.nix {cfg = cfg; })
    (import ./window-management.nix {cfg = cfg; })
  ];

  options.custom.plasma = {
    enable = lib.mkEnableOption "KDE Plasma config options";
    touchpads = lib.mkOption {
      default = [];
      description = "List of touchpad names for which to apply natural scrolling.";
      example = [ "Libinput/10248/260/ASUF1204:00 2808:0104 Touchpad" ];
      type = with lib.types; listOf (submodule {
        options = {
          name = lib.mkOption { type = str; };
          vendorId = lib.mkOption { type = str; };
          productId = lib.mkOption { type = str; };
        };
      });
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      kate.editor.brackets.automaticallyAddClosing = true;

      plasma = {
        enable = true;
        immutableByDefault = true;
        overrideConfig = true;

        desktop = {
          icons.lockInPlace = true;
          mouseActions.verticalScroll = "switchVirtualDesktop";
        };

        hotkeys.commands."launch-alacritty" = {
          name = "Launch Alacritty";
          key = "Alt+Z";
          command = "alacritty";
        };

        input = {
          keyboard = {
            layouts = [ { layout = "us"; } { layout = "ru"; } ];
            numlockOnStartup = "on";
          };
          touchpads = builtins.map
            (x: {
              enable = true;
              disableWhileTyping = true;
              naturalScroll = true;
              tapToClick = true;
            } // x)
            cfg.touchpads;
        };

        krunner = {
          activateWhenTypingOnDesktop = true;
          historyBehavior = "enableSuggestions";
          shortcuts.launch = "Meta+Alt";
        };

        shortcuts = {
          "KDE Keyboard Layout Switcher" = {
            "Switch to Last-Used Keyboard Layout" = [ "none" "Switch to Last-Used Keyboard Layout" ];
            "Switch to Next Keyboard Layout" = [ "Meta+Space" "Switch to Next Keyboard Layout" ];
          };

          kwin = {
            "Switch One Desktop Down" = "none";
            "Switch One Desktop Up" = "none";
            "Switch One Desktop to the Left" = [ "Meta+J" "Meta+Ctrl+Left" ];
            "Switch One Desktop to the Right" = [ "Meta+K" "Meta+Ctrl+Right"];
            "Window Maximize" = "Meta+Up";
            "Window Minimize" = "Meta+Down";
            "Window Quick Tile Top" = [ "none" "Quick Tile Window to the Top" ];
            "Window Quick Tile Bottom" = [ "none" "Quick Tile Window to the Bottom" ];
          };

          plasmashell = {
            "activate application launcher" = [ "Meta" "Activate Application Launcher" ];
          };
        };

        spectacle.shortcuts = {
          launch = "none";
          captureRectangularRegion = "Print";
        };

        workspace = {
          clickItemTo = "open";
          colorScheme = "BreezeLight";
          lookAndFeel = "org.kde.breezedark.desktop";
          wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/ScarletTree/contents/images/5120x2880.png";
        };

        configFile = {
          dolphinrc = {
            General.RememberOpenedTabs = false;
            "KFileDialog Settings" = {
              "Places Icons Auto-resize" = false;
              "Places Icons Static Size" = 22;
            };
          };

          kdeglobals.General = {
            AccentColor = "255,120,0";
            TerminalApplication = "alacritty";
            TerminalService = "Alacritty.desktop";
          };

          krunnerrc = {
            Plugins = {
              "helprunnerEnabled" = false;
              "krunner_appstreamEnabled" = false;
              "krunner_katesessionsEnabled" = false;
              "krunner_konsoleprofilesEnabled" = false;
              "krunner_kwinEnabled" = false;
              "krunner_plasma-desktopEnabled" = false;
              "krunner_powerdevilEnabled" = false;
              "krunner_shellEnabled" = false;
            };
            "Plugins/Favorites".plugins = builtins.concatStringsSep ","
              [ "windows" "krunner_services" "krunner_systemsettings" "calculator" "krunner_dictionary" "locations" ];
          };

          kwalletrc = {
            Wallet.Enabled = false;
            "org.freedesktop.secrets".apiEnabled = false;
          };

          kxkbrc.Layout.Options = "caps:backspace";

          plasmaparc.General.AudioFeedback = false;
        };
      };
    };
  };
}
