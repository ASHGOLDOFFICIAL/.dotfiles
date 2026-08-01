# Nvidia configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.hardware.nvidia;
in {
  options.custom.hardware.nvidia.enable = lib.mkEnableOption "Nvidia specific options";

  config = lib.mkIf cfg.enable {
    boot.kernelParams = [ "nvidia-drm.fbdev=1" ];
    
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          nvidia-vaapi-driver 
        ]; 
      };
      
      nvidia = {
        dynamicBoost.enable = true;
        modesetting.enable = true;
        nvidiaSettings = true;
        open = true;
        powerManagement = {
          enable = lib.mkDefault true;
          finegrained = false;
        };
        prime.offload.enableOffloadCmd = config.hardware.nvidia.prime.offload.enable;
      };
    };

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
