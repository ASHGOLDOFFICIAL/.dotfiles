{ config, pkgs, lib, ... }:

let
  cfg = config.custom.cli;
in {
  options.custom.cli.enable = lib.mkEnableOption "CLI apps and settings";

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      btop
      colordiff
      fastfetch
      ffmpeg
      gnumake
      imagemagick
      lm_sensors
      lshw
      p7zip
      python3
      speedtest-rs
      stow
      trash-cli
    ];

    programs = {
      git.enable = lib.mkDefault true;
      neovim = {
        enable = lib.mkDefault true;
        configure = {
          customRC = ''
            set autoindent
            set cursorline
            set expandtab
            set nowrap
            set number
            set relativenumber
            set shiftwidth=2
            set tabstop=2
          '';
        };
        defaultEditor = lib.mkDefault true;
      };
      proxychains = {
        enable = lib.mkDefault true;
        package = pkgs.proxychains-ng;
        proxies = {
          throne = {
            enable = true;
            type = "socks5";
            host = "127.0.0.1";
            port = 2080;
          };
        };
      };
      tmux.enable = lib.mkDefault true;
      zsh = {
        enable = lib.mkDefault true;
        autosuggestions.enable = true;
        interactiveShellInit = ''
          source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
        '';
        syntaxHighlighting.enable = true;
      };
    };
  };
}
