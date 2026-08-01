# Default GUI apps configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.gui;
  inherit (lib) mkDefault;
in {
  options.custom.gui.enable = lib.mkEnableOption "default GUI apps and settings";

  imports = [
    ./desktop
    ./firefox.nix
    ./gaming
    ./graphics.nix
    ./media.nix
    ./programming.nix
  ];
  
  config = lib.mkIf cfg.enable {

    custom.gui = {
      desktop.gnome.enable = true;
      firefox.enable = true;
    };

    environment = {
      systemPackages = with pkgs; ([
        alacritty
        antimicrox
        keepassxc
        libreoffice-fresh
        qbittorrent
        scrcpy
        telegram-desktop
        thunderbird
      ]);
    };

    fonts.packages = with pkgs; [
      nerd-fonts.bigblue-terminal
      nerd-fonts.hack
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      terminus_font
      tt2020
      uni-vga
    ];

    programs = {
      throne = {
        enable = true;
        tunMode.enable = true;
      };
    };

    services = {
      xserver = {
        excludePackages = [ pkgs.xterm ];
        wacom.enable = true;
        xkb = {
          layout = mkDefault "us,ru";
          variant = mkDefault "";
          options = mkDefault "terminate:ctrl_alt_bksp";
        };
      };
    };
  };
}

