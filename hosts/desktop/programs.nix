# Programs and packages to be installed

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  users.users.ashgoldofficial.packages = with pkgs; [
    alacritty
    calibre
    mkvtoolnix
    tiled
    thunderbird
    bottles
    protonup-qt
  ];
	
  # CLI apps
  environment.systemPackages = with pkgs; ([
    neofetch
    python3
    tldr
    unzip
    wine
    wl-clipboard 
  ]) ++

  # General GUI apps
  (with pkgs; [
    blanket
    geogebra6
    gimp
    inkscape
    kid3
    krita
    libreoffice
    libsForQt5.kdenlive
    lollypop
    obs-studio
    onlyoffice-bin
    sigil
    vlc
  ]) ++

  # Intetnet
  (with pkgs; [
    telegram-desktop
    qbittorrent
    webcord
  ]) ++

  # Games
  (with pkgs; [
    minetest
    prismlauncher
    superTuxKart
  ]);
  
  programs.dconf.enable = true;
  programs.firefox = {
    enable = true;
    preferences = {
      "intl.locale.requested" = "ru";
    };
    languagePacks = [ "ru" ];
  };
  programs.gamemode.enable = true;
  programs.git.enable = true;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.steam = {
    enable = true;
  };
  programs.tmux.enable = true;
  programs.zsh = {
    autosuggestions.enable = true;
    enable = true;
    syntaxHighlighting.enable = true;
  };
}
