
{ config, lib, pkgs, ... }:

let
  cfg = config.custom.gnome.extensions.blur-my-shell;
in {
  options.custom.gnome.extensions.blur-my-shell.enable = lib.mkEnableOption "Blur My Shell extension";

  config = lib.mkIf cfg.enable {
    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
        ];
      };
      
      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        blur = false;
      };

      "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
        blur = false;
      };
    };
  };
}
