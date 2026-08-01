# KDE Plasma desktop environment configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.gui.desktop.plasma;
in {
  options.custom.gui.desktop.plasma.enable = lib.mkEnableOption "KDE Plasma desktop environment";

  config = lib.mkIf cfg.enable {
    programs = {
      kdeconnect = {
        enable = lib.mkDefault true;
        package = lib.mkDefault pkgs.plasma5Packages.kdeconnect-kde;
      };
      firefox.preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
        "widget.use-xdg-desktop-portal.settings" = 1;
        "widget.use-xdg-desktop-portal.location" = 1;
        "widget.use-xdg-desktop-portal.open-uri" = 1;
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