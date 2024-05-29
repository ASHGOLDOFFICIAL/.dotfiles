# GNOME desktop environment configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.gnome;
in {
  options.custom.gnome = {
    enable = lib.mkEnableOption "GNOME desktop environment";
  };
  
  config = lib.mkIf cfg.enable {
    environment = {
      gnome.excludePackages = (with pkgs; [
        gnome-tour      # Tour
      ]) ++ (with pkgs.gnome; [
        epiphany        # Browser
        geary           # Email
        gnome-software  # Software
        totem           # Videos
        yelp            # Help
      ]);

      systemPackages = (with pkgs; [
        amberol
        blanket
        deja-dup
        denaro
        eyedropper
        fractal
        gnome-firmware
        gnome.gnome-tweaks
        junction
        newsflash
        parabolic
        # wildcard
      ]) ++ (with pkgs.gnomeExtensions; [
        alphabetical-app-grid
        bluetooth-battery-meter
        blur-my-shell
        forge
        gnome-bedtime
        rounded-corners
      ]);
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
        enable = true;
        package = pkgs.gnomeExtensions.gsconnect;
      };
      nautilus-open-any-terminal = {
        enable = true;
        terminal = "alacritty";
      };
      seahorse.enable = config.services.gnome.gnome-keyring.enable;
    };

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };

    services = {
      gnome.gnome-keyring.enable = lib.mkForce true;
      switcherooControl.enable = config.hardware.nvidia.prime.offload.enable;
      xserver = {
        desktopManager.gnome.enable = true;
        displayManager.gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
  };
}

