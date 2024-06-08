{ config, pkgs, lib, ... }@args:

let
  inherit (lib) mkDefault;
in {
  imports = [ ./modules ];
  
  boot = {
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = mkDefault true;
      efi.canTouchEfiVariables = mkDefault true;
    };
    plymouth.enable = mkDefault false;
  };

  environment.systemPackages = with pkgs; ([
    # kdePackages.kdenlive
    alacritty
    btop
    calibre
    colordiff
    fastfetch
    ffmpeg
    gimp
    godot_4
    inkscape
    inxi
    jetbrains.idea-community
    kdePackages.kalgebra
    keepassxc
    kid3
    kora-icon-theme
    krita
    lf
    libreoffice-fresh
    libsForQt5.kdenlive
    libsecret
    lm_sensors
    lollypop
    lshw
    mame-tools
    maxcso
    mc
    mcaselector
    neovide
    newsboat
    obs-studio
    openai-whisper-cpp
    pavucontrol
    python3
    qbittorrent
    scrcpy
    sigil
    speedtest-rs
    stow
    subtitleedit
    tealdeer
    telegram-desktop
    thunderbird
    tor-browser
    trash-cli
    unzip
    vlc
    wdiff
    webcord
    wl-clipboard
  ]);

  fonts.packages = with pkgs; [
    corefonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    roboto
    roboto-mono
    roboto-serif
    roboto-slab
    vistafonts
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  hardware.pulseaudio.enable = false;
  
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
  
  networking.networkmanager.enable = mkDefault true;
  
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
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
    nh = {
      enable = true;
      flake = ./.;
    };
    ssh.startAgent = true;
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
    xserver = {
      excludePackages = [ pkgs.xterm ];
      xkb = {
        layout = mkDefault "us,ru";
        variant = mkDefault "";
        options = mkDefault "terminate:ctrl_alt_bksp";
      };
    };
  };
  
  sound.enable = true;
  system.stateVersion = "24.05";
  time.timeZone = "Asia/Yekaterinburg";
  
  users = {
    defaultUserShell = pkgs.zsh;
    users.ashgoldofficial = {
      isNormalUser = true;
      description = "Andrey Shaat";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
