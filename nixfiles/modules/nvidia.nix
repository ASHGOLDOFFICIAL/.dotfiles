# Nvidia configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.nvidia;
in {
  options.custom.nvidia.enable = lib.mkEnableOption "Nvidia specific options";

  config = lib.mkIf cfg.enable {
    boot.kernelParams = [ "nvidia-drm.fbdev=1" ];
    
    hardware = {
      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;
        open = lib.mkDefault true;
        package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.production;
        powerManagement = {
          enable = lib.mkDefault true;
          finegrained = false;
        };
        prime.offload.enableOffloadCmd = config.hardware.nvidia.prime.offload.enable;
      };

      opengl = {
        enable = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [
          vaapiVdpau 
          nvidia-vaapi-driver 
        ]; 
      };
    };

    nixpkgs.config.cudaSupport = lib.mkDefault true;

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
