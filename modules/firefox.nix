{ config, pkgs, lib, ... }:

let
  cfg = config.custom.firefox;
in {
  options.custom.firefox = {
    enable = lib.mkEnableOption "Firefox web browser";
    nvidia-hardware-acceleration = lib.mkEnableOption
      "hardware acceleration on Nvidia";
  };

  config = lib.mkIf cfg.enable {
    environment.variables = lib.mkIf cfg.nvidia-hardware-acceleration {
      # Necessary to correctly enable va-api (video codec hardware
      # acceleration). If this isn't set, the libvdpau backend will be
      # picked, and that one doesn't work with most things, including
      # Firefox.
      LIBVA_DRIVER_NAME = "nvidia";
      # Required to run the correct GBM backend for nvidia GPUs on wayland
      GBM_BACKEND = "nvidia-drm";
      # Hardware cursors are currently broken on nvidia
      # WLR_NO_HARDWARE_CURSORS = "1";
      # Required to use va-api it in Firefox. See
      # https://github.com/elFarto/nvidia-vaapi-driver/issues/96
      MOZ_DISABLE_RDD_SANDBOX = "1";
      # It appears that the normal rendering mode is broken on recent
      # nvidia drivers:
      # https://github.com/elFarto/nvidia-vaapi-driver/issues/213#issuecomment-1585584038
      NVD_BACKEND = "direct";
      # Required for firefox 98+, see:
      # https://github.com/elFarto/nvidia-vaapi-driver#firefox
      EGL_PLATFORM = "wayland";
      # Enable Nvidia offload for Firefox
      __NV_PRIME_RENDER_OFFLOAD = 1;
      __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
      # Apparently, without this nouveau may attempt to be used instead
      # (despite it being blacklisted)
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __VK_LAYER_NV_optimus = "NVIDIA_only";
    };

    hardware.opengl.extraPackages = lib.mkIf cfg.nvidia-hardware-acceleration [
      pkgs.nvidia-vaapi-driver
    ];

    programs.firefox = {
      enable = true;
      languagePacks = [ "en-GB" "en-US" "ru" ];
      # package = pkgs.firefox-devedition;
      policies = {
        DisableTelemetry = true;
        DisablePocket = true;
        DontCheckDefaultBrowser = true;
      };
      preferences = lib.mkIf cfg.nvidia-hardware-acceleration {
        "gfx.webrender.all" = true; # Force enable GPU acceleration
        "media.ffmpeg.vaapi.enabled" = true;
        "widget.dmabuf.force-enabled" = true; # Required in recent Firefoxes
      };
    };
  };
}
