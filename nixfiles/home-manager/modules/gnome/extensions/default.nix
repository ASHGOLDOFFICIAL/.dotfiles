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
        enabled-extensions = with pkgs.gnomeExtensions; [
          alphabetical-app-grid.extensionUuid
          bluetooth-battery-meter.extensionUuid
          caffeine.extensionUuid
          gnome-bedtime.extensionUuid
          gsconnect.extensionUuid
          net-speed-simplified.extensionUuid
          pano.extensionUuid
          rounded-corners.extensionUuid
        ];
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
    };
  };
}
