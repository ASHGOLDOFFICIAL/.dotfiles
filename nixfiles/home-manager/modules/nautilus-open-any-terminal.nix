{ config, lib, pkgs, ... }:

let
  cfg = config.programs.nautilus-open-any-terminal;
in {
  options.programs.nautilus-open-any-terminal = {
    enable = lib.mkEnableOption "nautilus-open-any-terminal";

    terminal = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
      example = "alacritty";
      description = ''
        The terminal emulator to add to context-entry of nautilus. Supported terminal
        emulators are listed in https://github.com/Stunkymonkey/nautilus-open-any-terminal#supported-terminal-emulators.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.nautilus-python
      nautilus-open-any-terminal
    ];

    dconf.settings = lib.optionalAttrs (cfg.terminal != null) {
      "com/github/stunkymonkey/nautilus-open-any-terminal" = {
        terminal = cfg.terminal;
      };
    };
  };
}
