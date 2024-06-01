# Nvidia configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.nvidia;
in {
  options.custom.nvidia = {
    enable = lib.mkEnableOption "Nvidia specific options";
    laptop = {
      enable = lib.mkEnableOption "PRIME offload by default";
      syncSpecialisation = lib.mkOption {
        default = null;
        description = "Name of specialisation on which to enable PRIME Sync";
        example = "on-the-go";
        type = with lib.types; nullOr str;
      };
    };
  };

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
      };
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [
          vaapiVdpau 
          nvidia-vaapi-driver 
        ]; 
      };
    };

    hardware.nvidia.prime = lib.mkIf cfg.laptop.enable {
      offload = {
        enable = true;
        enableOffloadCmd = config.hardware.nvidia.prime.offload.enable;
      };
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    specialisation = lib.mkIf (cfg.laptop.syncSpecialisation != null) {
      ${cfg.laptop.syncSpecialisation}.configuration = {
        hardware.nvidia.prime = {
          offload.enable = lib.mkForce false;
          sync.enable = true;
        };
      };
    };
  };
}
