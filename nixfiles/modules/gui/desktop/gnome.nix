# GNOME desktop environment configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.gui.desktop.gnome;
in {
  options.custom.gui.desktop.gnome.enable = lib.mkEnableOption "GNOME desktop environment";
  
  config = lib.mkIf cfg.enable {
    environment = {
      gnome.excludePackages = (with pkgs; [
        epiphany
        geary
        gnome-tour
        totem
        yelp
      ]);

      systemPackages = (with pkgs; [
        amberol
        blanket
        dconf-editor
        denaro
        fractal
        gjs # https://github.com/NixOS/nixpkgs/issues/547995
        gnome-firmware
        gnome-kra-ora-thumbnailer
        gnome-tweaks
        gradia
        kora-icon-theme
        papers
        rufin
        wildcard
      ]) ++

      (with pkgs.gnomeExtensions; [
        alphabetical-app-grid
        auto-accent-colour
        bluetooth-battery-meter
        blur-my-shell
        caffeine
        copyous
        gnome-bedtime
        light-style
        net-speed-simplified
        pip-on-top
        random-wallpaper
        tiling-shell
      ]) ++

      (lib.optional config.programs.steam.enable pkgs.adwsteamgtk);
    };

    programs = {
      firefox = {
        nativeMessagingHosts.packages = [ pkgs.gnomeExtensions.gsconnect ];
        preferences = {
          "browser.gnome-search-provider.enabled" = true;
        };
      };

      kdeconnect = {
        enable = lib.mkDefault true;
        package = lib.mkDefault pkgs.gnomeExtensions.gsconnect;
      };

      nautilus-open-any-terminal = {
        enable = lib.mkDefault true;
        terminal = lib.mkDefault "alacritty";
      };
    };

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita";
    };

    services = {
      switcherooControl.enable = config.hardware.nvidia.prime.offload.enable;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };
}

