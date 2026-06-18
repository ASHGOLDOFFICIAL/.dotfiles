# Hyprland configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.hyprland;
in {
  options.custom.hyprland.enable = lib.mkEnableOption "Hyprland";
  
  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; ([
        kdePackages.dolphin
        rofi
        eww
        sass
      ]);
    };

    programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
      };
      nm-applet.enable = true;
      waybar.enable = false;
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
    };
  };
}

