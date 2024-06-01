{ lib, config, pkgs, ... }:

let
 cfg = config.custom.iwd;
in {
  options.custom.iwd.enable = lib.mkEnableOption "iwd backend for NetworkManager";
  
  config = lib.mkIf cfg.enable {
    networking = {
      networkmanager.wifi.backend = "iwd";
      wireless.iwd = {
        enable = true;
        settings.Settings.AutoConnect = true;
      };
    };
  };
}
