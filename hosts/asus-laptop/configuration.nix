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
    nvidia.enable = true;
  };
  
  hardware = {
    bluetooth = {
      enable = true;
      settings.General.Experimental = true;
    };
    cpu.intel.updateMicrocode = true;
    nvidia.prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  
  networking = {
    hostName = "aurum";
    networkmanager.wifi.backend = "iwd";
    wireless.iwd = {
      enable = true;
      settings.Settings.AutoConnect = true;
    };
  };

  programs = {
    adb.enable = true;
    virt-manager.enable = true;
  };

  services = {
    asusd.enable = true;
    fwupd.enable = true;
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
  
  system.nixos.tags = [ "offload" ];
  users.users.ashgoldofficial.extraGroups = [ "adbusers" "libvirtd" ];

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  specialisation = {
    on-ac.configuration = {
      system.nixos.tags = lib.mkForce [ "sync" ];

      hardware.nvidia = {
        prime = {
          offload = {
            enable = lib.mkForce false;
            enableOffloadCmd = lib.mkForce false;
          };
          sync.enable = lib.mkForce true;
        };
      };
    };
  };
}
