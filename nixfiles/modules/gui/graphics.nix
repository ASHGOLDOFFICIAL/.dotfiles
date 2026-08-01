# Default graphics apps configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.gui.graphics;
in {
  options.custom.gui.graphics.enable = lib.mkEnableOption "default graphics apps and settings";

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; ([
        gimp3
        inkscape
        krita
      ]);
    };
  };
}

