# Default programming apps configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.gui.programming;
in {
  options.custom.gui.programming.enable = lib.mkEnableOption "default programming";
  
  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; ([
        godot_4-mono
        jetbrains.idea
        jetbrains.pycharm
        jetbrains.rust-rover
        tiled
      ]);
    };

    nixpkgs.config.permittedInsecurePackages = [
      # godot_4-mono
      "dotnet-sdk-6.0.428"
    ];

    programs = {
      wireshark = {
        enable = true;
        package = pkgs.wireshark;
      };
    };
  };
}

