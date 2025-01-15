{ config, lib, pkgs, ... }:

let
  cfg = config.custom.gnome.extensions.tiling-shell;
in {
  options.custom.gnome.extensions.tiling-shell.enable = lib.mkEnableOption "Tiling Shell extension";

  config = lib.mkIf cfg.enable {
    dconf.settings = let
      inherit (lib.gvariant) mkUint32;
    in {
      "org/gnome/shell" = {
        enabled-extensions = with pkgs.gnomeExtensions; [
          tiling-shell.extensionUuid
        ];
      };

      "org/gnome/shell/extensions/tilingshell" = {
        enable-autotiling = true;
        outer-gaps = mkUint32 0;
        inner-gaps = mkUint32 0;

        layouts-json = builtins.toJSON [
          {
            "id" = "Layout 1";
            "tiles" = [
              {"x" = 0; "y" = 0; "width" = 0.5; "height" = 1; "groups" = [1];}
              {"x" = 0.5; "y" = 0; "width" = 0.5; "height" = 1; "groups" = [1];}
            ];
          }
          {
            "id" = "Layout 2";
            "tiles" = [
              {"x" = 0; "y" = 0; "width" = 0.33; "height" = 1; "groups" = [1];}
              {"x" = 0.33; "y" = 0; "width" = 0.67; "height" = 1; "groups" = [1];}
            ];
          }
          {
            "id" = "Layout 3";
            "tiles" = [
              {"x" = 0; "y" = 0; "width" = 0.67; "height" = 1; "groups" = [1];}
              {"x" = 0.67; "y" = 0; "width" = 0.33; "height" = 1; "groups" = [1];}
            ];
          }
        ];
      };
    };
  };
}
