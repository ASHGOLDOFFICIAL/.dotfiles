{ config, lib, pkgs, ... }:

let
  cfg = config.custom.gnome;
in {
  imports = [
    ./epiphany.nix
  ];

  options.custom.gnome.enable = lib.mkEnableOption "GNOME config options";

  config = lib.mkIf cfg.enable {
    dconf.settings = let
      inherit (lib.gvariant)
        mkDictionaryEntry
        mkDouble
        mkEmptyArray
        mkInt32
        mkTuple
        mkVariant
        mkUint32;
      
      locations = [
        (mkVariant (mkTuple [
          (mkUint32 2)
          (mkVariant (mkTuple [
            "Coordinated Universal Time (UTC)" "@UTC" false
            (mkEmptyArray "(dd)") (mkEmptyArray "(dd)")
          ]))
        ]))
        (mkVariant (mkTuple [
          (mkUint32 2)
          (mkVariant (mkTuple [
            "Moscow" "UUWW" true
            [(mkTuple (map mkDouble [
              0.97127572873484425 0.65042604039431762
            ]))]
            [(mkTuple (map mkDouble [
              0.97305983920281813 0.65651530216830811
            ]))]
          ]))
        ]))
      ];

      folders = [
        "accessories"
        "education"
        "emulators"
        "gaming"
        "graphics"
        "internet"
        "office"
        "programming"
        "sound---video"
        "system-tools"
        "waydroid"
      ];
    in {
      "org/gnome/clocks" = {
        world-clocks = map
          (location: [(mkDictionaryEntry "location" location)])
          locations;
      };

      "org/gnome/desktop/app-folders" = {
        folder-children = folders;
      };
      "org/gnome/desktop/app-folders/folders/accessories" = {
        name = "Accessories";
        categories = [ "Utility" ];
      };
      "org/gnome/desktop/app-folders/folders/education" = {
        name = "Education";
        categories = [ "Education" ];
      };
      "org/gnome/desktop/app-folders/folders/emulators" = {
        name = "Emulators";
        categories = [ "Emulator" ];
      };
      "org/gnome/desktop/app-folders/folders/gaming" = {
        name = "Gaming";
        categories = [ "Game" ];
      };
      "org/gnome/desktop/app-folders/folders/graphics" = {
        name = "Graphics";
        categories = [ "Graphics" ];
      };
      "org/gnome/desktop/app-folders/folders/internet" = {
        name = "Internet";
        categories = [ "Email" "Network" "WebBrowser" ];
        excluded-apps = [ "steam.desktop" ];
      };
      "org/gnome/desktop/app-folders/folders/office" = {
        name = "Office";
        categories = [ "Office" ];
      };
      "org/gnome/desktop/app-folders/folders/programming" = {
        name = "Programming";
        categories = [ "Development" ];
      };
      "org/gnome/desktop/app-folders/folders/sound---video" = {
        name = "Sound & Video";
        categories = [ "Audio" "AudioVideo" "Video" ];
      };
      "org/gnome/desktop/app-folders/folders/system-tools" = {
        name = "System Tools";
        categories = [ "System" "Settings" ];
      };
      "org/gnome/desktop/app-folders/folders/waydroid" = {
        name = "WayDroid";
        categories = [ "X-WayDroid-App" ];
      };

      "org/gnome/desktop/input-sources" = {
        sources = [
          (mkTuple [ "xkb" "us" ])
          (mkTuple [ "xkb" "ru" ])
        ];
        xkb-options = [
          "terminate:ctrl_alt_bksp"
          "caps:ctrl_modifier"
        ];
      };

      "org/gnome/desktop/interface" = {
        accent-color = "yellow";
        clock-format = "12h";
        clock-show-weekday = true;
        cursor-theme = "Adwaita";
        enable-hot-corners = false;
        font-name = "Cantarell 11";
        gtk-theme = "Adwaita";
        icon-theme = "kora";
        show-battery-percentage = true;
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,close";
        num-workspaces = mkInt32 6;
      };
      "org/gnome/mutter" = {
        center-new-windows = true;
        dynamic-workspaces = false;
        edge-tiling = true;
        experimental-features = [ "variable-refresh-rate" ];
      };
      "org/gnome/nautilus/preferences" = {
        click-policy = "single";
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
        switch-to-workspace-left = [ "<Alt><Super>j" ];
        switch-to-workspace-right = [ "<Alt><Super>k" ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Alt>z";
        command = "alacritty";
        name = "Open alacritty";
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          alphabetical-app-grid.extensionUuid
          bluetooth-battery-meter.extensionUuid
          blur-my-shell.extensionUuid
          caffeine.extensionUuid
          gnome-bedtime.extensionUuid
          gsconnect.extensionUuid
          net-speed-simplified.extensionUuid
          pano.extensionUuid
          rounded-corners.extensionUuid
          tiling-shell.extensionUuid
        ];
        # TODO: check if apps are installed
        favorite-apps = [
          "steam.desktop"
          "firefox.desktop"
          # "firefox-devedition.desktop"
          "org.telegram.desktop.desktop"
          "org.gnome.Nautilus.desktop"
          "org.keepassxc.KeePassXC.desktop"
          "io.gitlab.news_flash.NewsFlash.desktop"
          "vlc.desktop"
          "subtitleedit.desktop"
          "org.es_de.frontend.desktop"
        ];
      };
      
      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };

      "org/gnome/shell/extensions/alphabetical-app-grid" = {
        folder-order-position = "start";
      };
      "org/gnome/shell/extensions/bedtime-mode" = {
        ondemand-button-location = "menu";
      };
      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        blur = false;
      };
      "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
        blur = false;
      };
      "org/gnome/shell/extensions/forge" = {
        move-pointer-focus-enabled = false;
        quick-settings-enabled = false;
        window-gap-size-increment = mkUint32 0;
      };
      "org/gnome/shell/extensions/lennart-k/rounded_corners" = {
        corner-radius = mkInt32 16;
      };
      "org/gnome/shell/extensions/netspeedsimplified" = {
        iconstoright = true;
        lockmouseactions = true;
        mode = 3;
        systemcolr = true;
        togglebool = false;
        wpos = 1;
      };
      "org/gnome/shell/world-clocks" = {
        world-clocks = locations;
      };
      "org/gnome/TextEditor" = {
        restore-session = false;
      };
    };
  };
}
