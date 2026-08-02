{ config, pkgs, pkgsStable, pkgsUnstable, lib, ... }@args:

{
  imports = [ ./modules ];
  
  boot = {
    loader = {
      systemd-boot.enable = lib.mkDefault true;
      efi.canTouchEfiVariables = lib.mkDefault true;
    };
    plymouth.enable = lib.mkDefault false;
  };
  
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = lib.mkDefault "ru_RU.UTF-8";
      LC_IDENTIFICATION = lib.mkDefault "ru_RU.UTF-8";
      LC_MEASUREMENT = lib.mkDefault "ru_RU.UTF-8";
      LC_MONETARY = lib.mkDefault "ru_RU.UTF-8";
      LC_NAME = lib.mkDefault "en_US.UTF-8";
      LC_NUMERIC = lib.mkDefault "ru_RU.UTF-8";
      LC_PAPER = lib.mkDefault "ru_RU.UTF-8";
      LC_TELEPHONE = lib.mkDefault "ru_RU.UTF-8";
      LC_TIME = lib.mkDefault "en_US.UTF-8";
    };
  };
  
  networking = {
    networkmanager.enable = lib.mkDefault true;
  };
  
  nix = {
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "flakes" "nix-command" ];
    };
  };

  nixpkgs.config.allowUnfree = lib.mkDefault true;

  programs.nh.enable = lib.mkDefault true;

  security.rtkit.enable = lib.mkDefault true;

  services = {
    fwupd.enable = lib.mkDefault true;
    pipewire = {
      enable = lib.mkDefault true;
      alsa.enable = lib.mkDefault true;
      alsa.support32Bit = lib.mkDefault true;
      pulse.enable = lib.mkDefault true;
    };
  };

  system.stateVersion = "24.05";
  time.timeZone = lib.mkDefault "Asia/Yekaterinburg";
}
