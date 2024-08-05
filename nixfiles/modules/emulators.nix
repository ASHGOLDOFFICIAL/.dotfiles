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
      
      xdelta
      mame 
      
      (retroarch.override {
        cores = with libretro; ([
          beetle-pce       # pcenginecd
          beetle-pce-fast  # pcenginecd
          beetle-wswan     # wonderswan
          bsnes            # snes
          fbneo            # arcade
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
          assets_directory = "${pkgs.retroarch-assets}/share/retroarch/assets";
          gamemode_enable = if config.programs.gamemode.enable then "true" else "false";
          joypad_autoconfig_dir = "${pkgs.retroarch-joypad-autoconfig}/share/libretro/autoconfig";
          libretro_info_path = "${pkgs.libretro-core-info}/share/retroarch/cores";
          menu_driver = "xmb";
          menu_shader_pipeline = "2";
          menu_swap_ok_cancel_buttons = "false"; # Japanese
          ozone_menu_color_theme = "12";
          quit_on_close_content = "2"; # CLI
          use_last_start_directory = "true";
          video_fullscreen = "true";
          xmb_menu_color_theme = "1";
        } // cfg.retroarchExtraConfig;
      })
    ] ++

    lib.optionals cfg.pc [
      (pkgs.callPackage ../packages/quasi88.nix {})
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
