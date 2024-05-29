# Nvidia configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.nvidia;
in {
  options.custom.nvidia = {
    enable = lib.mkEnableOption "Nvidia specific options";
  };

  config = lib.mkIf cfg.enable {
    boot.kernelParams = [ "nvidia-drm.fbdev=1" ];
    
    hardware = {
      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;
        open = lib.mkDefault true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        powerManagement = {
          enable = lib.mkDefault true;
          finegrained = false;
        };
      };
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
    };

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
