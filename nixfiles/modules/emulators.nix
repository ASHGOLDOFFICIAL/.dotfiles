{ config, pkgs, lib, ... }:

let
  cfg = config.custom.emulators;
in {
  options.custom.emulators = {
    enable = lib.mkEnableOption "emulators";
    
    pc = lib.mkEnableOption "retro PC emulators";
    fifthGeneration = lib.mkEnableOption "fifth generation emulators";
    sixthGeneration = lib.mkEnableOption "sixth generation emulators";
    seventhGeneration = lib.mkEnableOption "seventh generation emulators";
    
    retroarchExtraConfig = lib.mkOption {
      default = {};
      example = {
        video_driver = "vulkan";
        video_refresh_rate = "144.000000";
      };
      description = "Additional settings that may vary diffrent machines.";
      type = with lib.types; attrsOf str;
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config = {
      permittedInsecurePackages = [
        # es-de
        "freeimage-unstable-2021-11-01"
      ];
    };

    environment.systemPackages = with pkgs; ([
      (pkgs.callPackage ../packages/es-de.nix {})
      
      mame 
      
      (retroarch.override {
        cores = with libretro; ([
          beetle-pce       # pcenginecd
          beetle-pce-fast  # pcenginecd
          beetle-wswan     # wonderswan
          bsnes            # snes
          fbneo            # arcade
          fceumm           # nes
          gambatte         # gb, gbc
          genesis-plus-gx  # genesis
          mesen            # nes
          mesen-s          # snes
          mgba             # bga
          puae             # amiga
          sameboy          # gb, gbc
          snes9x           # snes
        ] ++

        lib.optionals cfg.pc [
          bluemsx          # msx
          dosbox           # dos
          dosbox-pure      # dos
          fmsx             # msx
          np2kai           # pc98
          puae             # amiga
        ] ++

        lib.optionals cfg.fifthGeneration [
          beetle-psx-hw    # psx
          beetle-saturn    # saturn
          melonds          # nds
          mupen64plus      # n64
          parallel-n64     # n64
        ] ++
        
        lib.optionals cfg.sixthGeneration [
          flycast          # dreamcast
          dolphin          # gc
        ] ++ 

        lib.optionals cfg.seventhGeneration [
          dolphin          # wii
        ]);
        
        settings = {
          # Directories
          assets_directory = "${pkgs.retroarch-assets}/share/retroarch/assets";
          joypad_autoconfig_dir = "${pkgs.retroarch-joypad-autoconfig}/share/libretro/autoconfig";
          libretro_info_path = "${pkgs.libretro-core-info}/share/retroarch/cores";
          
          # General
          content_runtime_log_aggregate = "true";
          gamemode_enable = if config.programs.gamemode.enable then "true" else "false";
          input_max_users = "2";
          quit_on_close_content = "2"; # CLI
          video_fullscreen = "true";
          
          # Menu & Theme
          menu_driver = "xmb";
          menu_shader_pipeline = "2";
          menu_swap_ok_cancel_buttons = "true"; # Non-Japanese
          ozone_menu_color_theme = "12";
          xmb_menu_color_theme = "1";

          # RetroAchievements
          cheevos_enable = "true";
          cheevos_hardcore_mode_enable = "true";
        } // cfg.retroarchExtraConfig;
      })
    ] ++

    lib.optionals cfg.pc [
      # (pkgs.callPackage ../packages/quasi88.nix {})
    ] ++

    lib.optionals cfg.fifthGeneration [
      duckstation  # psx
      melonDS      # nds
      ppsspp       # psp
    ] ++

    lib.optionals cfg.sixthGeneration [
      dolphin-emu  # gc, wii
      flycast      # dreamcast
      pcsx2        # ps2
      xemu         # xbox
    ] ++

    lib.optionals cfg.seventhGeneration [
      dolphin-emu  # gc, wii
      rpcs3        # ps3
    ]);
  };
}
