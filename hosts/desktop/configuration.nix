{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../defaults.nix
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  custom = {
    firefox.enable = true;
    gaming.enable = true;
    gnome.enable = true;
    nvidia.enable = true;
  };
  
  hardware = {
    nvidia.open = false;
    sane = {
      enable = true;
      extraBackends = [ pkgs.epkowa ];
    };
  };

  i18n = {
    defaultLocale = "ru_RU.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };
  
  networking.hostName = "ferrum";
  
  nix.settings = {
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };
  programs.anime-game-launcher.enable = true;

  services = {
    flatpak.enable = true;
    printing = {
      enable = true;
      drivers = with pkgs; [ epson_201207w gutenprint ];
    };
    xserver.xkb.options = "";
  };

  users.users = {
    ashgoldofficial.extraGroups = [ "scanner" "lp" ];
    maria = {
      isNormalUser = true;
      description = "Maria Duzhenko";
      extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ];
    };
    sergei = {
      isNormalUser = true;
      description = "Sergei Duzhenko";
      extraGroups = [ "networkmanager" "scanner" "lp" ];
    };
    daria = {
      isNormalUser = true;
      description = "Daria Duzhenko";
      extraGroups = [ "scanner" "lp" ];
    };
  };  
}
