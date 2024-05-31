{ config, pkgs, lib, ... }@args:

{
  imports = [
    ./hardware-configuration.nix
    ../../defaults.nix
  ];
  
  custom = {
    emulators = {
      enable = true;
      fifthGeneration = true;
      sixthGeneration = true;
      seventhGeneration = true;
    };
    firefox.enable = true;
    gaming.enable = true;
    gnome.enable = true;
    iwd.enable = true;
    nvidia = {
      enable = true;
      laptop = {
        enable = true;
        syncSpecialisation = "ac";
      };
    };
  };
  
  hardware = {
    bluetooth = {
      enable = true;
      settings.General.Experimental = true;
    };
    cpu.intel.updateMicrocode = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
  
  networking.hostName = "aurum";

  programs = {
    adb.enable = true;
    virt-manager.enable = true;
  };

  services = {
    asusd.enable = true;
    power-profiles-daemon.enable = !config.services.tlp.enable;
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        # Battery settings
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
        START_CHARGE_THRESH_BAT1 = 75;
        STOP_CHARGE_THRESH_BAT1 = 80;

        # Platform
        PLATFORM_PROFILE_ON_BAT = "low-power";
        PLATFORM_PROFILE_ON_AC = "perfomance";

        # Processor
        CPU_SCALING_MAX_FREQ_ON_AC = 3200000;
        CPU_BOOST_ON_BAT = 0;
        CPU_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
      };
    };
  };
  
  users.users.ashgoldofficial.extraGroups = [ "adbusers" "libvirtd" ];

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
