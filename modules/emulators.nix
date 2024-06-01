{ config, pkgs, lib, ... }:

let
  cfg = config.custom.emulators;
in {
  options.custom.emulators = {
    enable = lib.mkEnableOption "emulators";
    arcade = lib.mkEnableOption "arcade emulators"; 
    fifthGeneration = lib.mkEnableOption "fifth generation emulators";
    sixthGeneration = lib.mkEnableOption "sixth generation emulators";
    seventhGeneration = lib.mkEnableOption "seventh generation emulators";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config = {
      permittedInsecurePackages = [
        # emulationstation-de
        "freeimage-unstable-2021-11-01"
      ];
    };

    environment.systemPackages = with pkgs; ([
      (callPackage ../packages/es-de.nix {})
      retroarch-assets
      retroarch-joypad-autoconfig
      (retroarch.override {
        cores = with libretro; ([
          bluemsx          # MSX
          bsnes            # SNES
          gambatte         # GB, GBC
          genesis-plus-gx  # Genesis
          mesen            # NES
          mesen-s          # SNES
          mgba             # GBA
          puae             # Amiga
          sameboy          # GB/GBC
          snes9x           # SNES
        ] ++

        lib.optional cfg.arcade fbneo ++

        lib.optionals cfg.fifthGeneration [
          beetle-saturn    # Saturn
          parallel-n64     # N64
        ]
        );
        
        settings = {
          "gamemode_enable" = if config.programs.gamemode.enable 
            then "true" else "false";
          "quit_on_close_content" = "2"; # cli
        };
      })
    ] ++

    lib.optional cfg.arcade mame ++

    lib.optionals cfg.fifthGeneration [
      duckstation  # PSX
      melonDS      # NDS
      ppsspp       # PSP
    ] ++

    lib.optionals cfg.sixthGeneration [
      dolphin-emu  # GC, Wii
      flycast      # Dreamcast
      pcsx2        # PS2
      xemu         # Xbox
    ] ++

    lib.optionals cfg.seventhGeneration [
      dolphin-emu  # GC, Wii
      rpcs3        # PS3
    ]
    );
  };
}
