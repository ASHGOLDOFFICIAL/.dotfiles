{ config, pkgs, lib, ... }:

let
  cfg = config.custom.firefox;
in {
  options.custom.firefox = {
    enable = lib.mkEnableOption "Firefox web browser";
    nvidiaHardwareAcceleration = lib.mkEnableOption
      "hardware acceleration on Nvidia";
  };

  config = lib.mkIf cfg.enable {
    environment.variables = lib.mkIf cfg.nvidiaHardwareAcceleration {
      # https://github.com/elFarto/nvidia-vaapi-driver?tab=readme-ov-file#firefox
      LIBVA_DRIVER_NAME = "nvidia";
      MOZ_DISABLE_RDD_SANDBOX = "1";
      
      # Enable Nvidia offload for Firefox
      __NV_PRIME_RENDER_OFFLOAD = 1;
      __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
      
      # Apparently, without this nouveau may attempt to be used instead
      # (despite it being blacklisted)
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __VK_LAYER_NV_optimus = "NVIDIA_only";
    };

    hardware.opengl.extraPackages = lib.mkIf cfg.nvidiaHardwareAcceleration [
      pkgs.nvidia-vaapi-driver
    ];

    programs.firefox = {
      enable = true;
      languagePacks = [ "en-GB" "en-US" "ru" ];
      # package = pkgs.firefox-devedition;
      policies = {
        DisableTelemetry = lib.mkDefault true;
        DisablePocket = lib.mkDefault true;
        DontCheckDefaultBrowser = lib.mkDefault true;
      };
      preferences = lib.mkIf cfg.nvidiaHardwareAcceleration {
        "gfx.webrender.all" = true; # Force enable GPU acceleration
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "widget.dmabuf.force-enabled" = true; # Required in 500+ drivers
      };
    };
  };
}
