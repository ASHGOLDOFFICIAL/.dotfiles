# GNOME desktop environment configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.gnome;
in {
  options.custom.gnome.enable = lib.mkEnableOption "GNOME desktop environment";
  
  config = lib.mkIf cfg.enable {
    environment = {
      gnome.excludePackages = (with pkgs; [
        epiphany        # Browser
        geary           # Email
        gnome-tour      # Tour
        totem           # Videos
        yelp            # Help
      ]);

      systemPackages = (with pkgs; [
        amberol
        blanket
        dconf-editor
        denaro
        fractal
        gnome-firmware
        gnome-kra-ora-thumbnailer
        gnome-tweaks
        gradia
        gst_all_1.gstreamer
        papers
        wildcard
      ]) ++

      (with pkgs.gnomeExtensions; [
        alphabetical-app-grid
        bluetooth-battery-meter
        blur-my-shell
        caffeine
        copyous
        gnome-bedtime
        live-lock-screen
        net-speed-simplified
        pip-on-top
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

