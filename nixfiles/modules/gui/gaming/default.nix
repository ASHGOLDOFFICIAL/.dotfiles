{ config, pkgs, lib, ... }:

let
  cfg = config.custom.gui.gaming;
in {
  options.custom.gui.gaming.enable = lib.mkEnableOption "gaming specific options";

  imports = [
    ./emulators.nix
  ];

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      boxflat
      opentrack
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
