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
        # evince          # Documents
        geary           # Email
        gnome-software  # Software
        gnome-tour      # Tour
        totem           # Videos
        yelp            # Help
      ]);

      systemPackages = (with pkgs; [
        amberol
        blanket
        dconf-editor
        denaro
        gnome-firmware
        gnome-tweaks
        newsflash
        papers
        wildcard
      ]) ++

      (with pkgs.gnomeExtensions; [
        alphabetical-app-grid
        bluetooth-battery-meter
        blur-my-shell
        caffeine
        gnome-bedtime
        net-speed-simplified
        # pano
        rounded-corners
        tiling-shell
      ]) ++

      (lib.optional config.programs.steam.enable pkgs.adwsteamgtk);
    };

    programs = {
      firefox = {
        nativeMessagingHosts.packages = [
          pkgs.gnomeExtensions.gsconnect
        ];
        preferences = {
          "browser.gnome-search-provider.enabled" = true;
        };
      };

      kdeconnect = {
        enable = lib.mkDefault true;
        package = pkgs.gnomeExtensions.gsconnect;
      };

      nautilus-open-any-terminal = {
        enable = lib.mkDefault true;
        terminal = lib.mkDefault "alacritty";
      };
    };

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };

    services = {
      switcherooControl.enable = config.hardware.nvidia.prime.offload.enable;
      xserver = {
        enable = true;
        desktopManager.gnome.enable = true;
        displayManager.gdm = {
          enable = true;
          wayland = lib.mkDefault true;
        };
      };
    };
  };
}

