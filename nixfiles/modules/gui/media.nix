# Default media apps configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.gui.media;
in {
  options.custom.gui.media.enable = lib.mkEnableOption "default media apps";
  
  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; ([
        calibre
        kdePackages.kdenlive
        kid3
        obs-studio
        sigil
        subtitleedit
        vlc
      ]);
    };
  };
}

