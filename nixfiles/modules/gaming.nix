{ config, pkgs, lib, ... }:

let
  cfg = config.custom.gaming;
in {
  options.custom.gaming.enable = lib.mkEnableOption "gaming specific options";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      adwsteamgtk
      dwarf-fortress
      gzdoom
      lutris
      mindustry-wayland
      minetest
      prismlauncher
      superTuxKart
      theforceengine
    ];

    programs = {
      gamemode = {
        enable = lib.mkDefault true;
        enableRenice = true;
        # settings.custom = let
        #   notification = flags: message:
        #   "${pkgs.libnotify}/bin/notify-send ${flags} -a 'GameMode' -i 'input-gaming' ${message}";
        # in {
        #   start = notification "-u low" "'GameMode is on'";
        #   end = notification "-u low" "'GameMode is off'";
        # };
      };
      gamescope = {
        enable = lib.mkDefault true;
        capSysNice = true;
      };
      steam = {
        enable = lib.mkDefault true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
        gamescopeSession.enable = true;
        protontricks.enable = true;
      };
    };
  };
}
