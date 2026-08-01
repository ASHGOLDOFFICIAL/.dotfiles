{ config, pkgs, pkgsStable, pkgsUnstable, lib, ... }@args:

let
  inherit (lib) mkDefault;
in {
  imports = [ ./modules ];
  
  boot = {
    loader = {
      systemd-boot.enable = mkDefault true;
      efi.canTouchEfiVariables = mkDefault true;
    };
    plymouth.enable = mkDefault false;
  };

  environment = {
    systemPackages = with pkgs; ([
      btop
      colordiff
      fastfetch
      ffmpeg
      gettext
      gnumake
      imagemagick
      lm_sensors
      lshw
      p7zip
      python3
      speedtest-rs
      stow
      tealdeer
      trash-cli
      whisper-cpp
    ]);
  };
  
  i18n = {
    defaultLocale = mkDefault "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = mkDefault "ru_RU.UTF-8";
      LC_IDENTIFICATION = mkDefault "ru_RU.UTF-8";
      LC_MEASUREMENT = mkDefault "ru_RU.UTF-8";
      LC_MONETARY = mkDefault "ru_RU.UTF-8";
      LC_NAME = mkDefault "en_US.UTF-8";
      LC_NUMERIC = mkDefault "ru_RU.UTF-8";
      LC_PAPER = mkDefault "ru_RU.UTF-8";
      LC_TELEPHONE = mkDefault "ru_RU.UTF-8";
      LC_TIME = mkDefault "en_US.UTF-8";
    };
  };
  
  networking = {
    networkmanager.enable = mkDefault true;
  };
  
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "flakes" "nix-command" ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    git.enable = true;
    neovim = {
      enable = true;
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
      defaultEditor = true;
    };
    nh.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        fuse
      ];
    };
    proxychains = {
      enable = true;
      package = pkgs.proxychains-ng;
      proxies = {
        nekoray = {
          enable = true;
          type = "socks5";
          host = "127.0.0.1";
          port = 2080;
        };
      };
    };
    tmux.enable = true;
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      interactiveShellInit = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      '';
      syntaxHighlighting.enable = true;
    };
  };

  security.rtkit.enable = true;

  services = {
    fwupd.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  system.stateVersion = "24.05";
  time.timeZone = "Asia/Yekaterinburg";
  
  users = {
    defaultUserShell = pkgs.zsh;
    users.ashgoldofficial = {
      isNormalUser = true;
      description = "Andrey Shaat";
      extraGroups = [ "networkmanager" "wheel" "wireshark" ];
    };
  };
}
