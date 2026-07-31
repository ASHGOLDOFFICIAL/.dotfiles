{ config, pkgs, lib, ... }:

let
  cfg = config.custom.gaming;
in {
  options.custom.gaming.enable = lib.mkEnableOption "gaming specific options";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      boxflat
      prismlauncher
    ];

    programs = {
      gamemode = {
        enable = lib.mkDefault true;
        enableRenice = true;
      };
      gamescope = {
        enable = lib.mkDefault true;
        capSysNice = true;
      };
      steam = {
        enable = lib.mkDefault true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
        gamescopeSession.enable = true;
      };
    };

    services.udev.packages = with pkgs; [
      boxflat
    ];
  };
}
