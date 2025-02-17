# KDE Plasma desktop environment configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.plasma;
in {
  options.custom.plasma.enable = lib.mkEnableOption "KDE Plasma desktop environment";

  config = lib.mkIf cfg.enable {
    programs = {
      kdeconnect = {
        enable = lib.mkDefault true;
        package = lib.mkDefault pkgs.plasma5Packages.kdeconnect-kde;
      };
    };

    services = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      desktopManager.plasma6.enable = true;
    };
  };
}