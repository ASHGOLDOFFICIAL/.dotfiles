{ config, lib, pkgs, ... }:

let
  cfg = config.custom.gnome.extensions;
in {
  imports = [
    ./blur-my-shell.nix
    ./tiling-shell.nix
  ];

  options.custom.gnome.extensions.enable = lib.mkEnableOption "GNOME extensions";

  config = lib.mkIf cfg.enable {
    custom.gnome.extensions.blur-my-shell.enable = lib.mkDefault true;
    custom.gnome.extensions.tiling-shell.enable = lib.mkDefault true;

    dconf.settings = let
      inherit (lib.gvariant) mkInt32;
    in {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = map (x: x.extensionUuid)
          (with pkgs.gnomeExtensions; [
            alphabetical-app-grid
            auto-accent-colour
            bluetooth-battery-meter
            caffeine
            copyous
            gnome-bedtime
            gsconnect
            light-style
            net-speed-simplified
            pip-on-top
            random-wallpaper
            wack-sonoma-lockscreen
          ]);
      };

      "org/gnome/shell/extensions/alphabetical-app-grid" = {
        folder-order-position = "start";
      };
      "org/gnome/shell/extensions/bedtime-mode" = {
        ondemand-button-location = "menu";
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
      "org/gnome/shell/extensions/pip-on-top" = {
        stick = true;
      };
      "org/gnome/shell/extensions/space-iflow-randomwallpaper" = {
        auto-fetch = true;
        change-type = 2;
        hide-panel-icon = true;

        hours = 0;
        minutes = 7;

        sources = [ "0" ];
      };
      "org/gnome/shell/extensions/space-iflow-randomwallpaper/sources/general/0" = {
        name = "GNOME Backgrounds";
        type = 4;
      };
      "org/gnome/shell/extensions/space-iflow-randomwallpaper/sources/localFolder/0" = {
        folder = "${config.xdg.dataHome}/backgrounds";
      };
      "org/gnome/shell/extensions/wack-lockscreen-clock" = {
        lockscreen-mode = "cupertino";
      };
    };
  };
}
