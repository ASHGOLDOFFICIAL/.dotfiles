{ config, pkgs, lib, ... }@args:

let
  cfg = config.custom.gaming;
in {
  options.custom.gaming = {
    enable = lib.mkEnableOption "gaming specific options";
  };

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
  
    nixpkgs.config = {
      allowUnfreePredicate = pkg: (
        builtins.elem (lib.getName pkg) (map lib.getName (with pkgs; [
          dwarf-fortress
        ])));
    };

    programs = {
      gamemode = {
        enable = true;
        enableRenice = true;
        settings.custom = {
          start = "${pkgs.libnotify}/bin/notify-send -u normal -a 'GameMode' -i 'input-gaming' 'GameMode is on'";
          end = "${pkgs.libnotify}/bin/notify-send -u normal -a 'GameMode' -i 'input-gaming' 'GameMode is off'";
        };
      };
      gamescope = {
        enable = true;
        capSysNice = true;
        env = {
          "__NV_PRIME_RENDER_OFFLOAD" = "1";
          "__VK_LAYER_NV_optimus" = "NVIDIA_only";
          "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
        };
      };
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
        gamescopeSession.enable = true;
      };
    };
  };
}
