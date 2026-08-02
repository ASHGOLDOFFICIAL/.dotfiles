{ config, pkgs, lib, ... }@args:

{
  imports = [
    ./hardware-configuration.nix
    ../../defaults.nix
  ];
  
  custom = {
    cli.enable = true;
    gui = {
      enable = true;
      gaming = {
        enable = true;
        emulators = {
          enable = true;
          pc = true;
          fifthGeneration = true;
          sixthGeneration = true;

          retroarchExtraConfig = {
            netplay_nickname = "ASHGOLDOFFICIAL";
            video_driver = "vulkan";
            video_refresh_rate = "144.000000";
          };
        };
      };
      graphics.enable = true;
      media.enable = true;
      programming.enable = true;
    };
    hardware.nvidia.enable = true;
    iwd.enable = true;
    server.media.enable = false;
  };
  
  environment = {
    systemPackages = with pkgs; ([
      tor-browser
    ]);
  };

  hardware = {
    bluetooth = {
      enable = true;
      settings.General.Experimental = true;
    };
    cpu.intel.updateMicrocode = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      prime = {
        offload.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  networking.hostName = "aurum";

  programs = {
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
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
        START_CHARGE_THRESH_BAT1 = 40;
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

  users = {
    defaultUserShell = pkgs.zsh;
    users.ashgoldofficial = {
      isNormalUser = true;
      description = "Andrey Shaat";
      extraGroups = [
        "adbusers"
        "libvirtd"
        "networkmanager"
        "wheel"
        "wireshark"
      ];
    };
  };
  virtualisation = {
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
