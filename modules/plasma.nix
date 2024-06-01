# Plasma desktop environment configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.plasma;
in {
  options.custom.plasma = {
    enable = lib.mkEnableOption "KDE Plasma 6";
  };
  
  config = lib.mkIf cfg.enable {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
    };
  };
}
