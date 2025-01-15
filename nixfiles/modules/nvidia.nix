# Nvidia configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.nvidia;
in {
  options.custom.nvidia.enable = lib.mkEnableOption "Nvidia specific options";

  config = lib.mkIf cfg.enable {
    boot.kernelParams = [
      "nvidia-drm.fbdev=1"
    ];
    
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          vaapiVdpau 
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

    # nix.settings = {
    #   substituters = [
    #     "https://cuda-maintainers.cachix.org"
    #   ];
    #   trusted-public-keys = [
    #     "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    #   ];
    # };
    # nixpkgs.config.cudaSupport = lib.mkDefault true;

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
