# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/f689f003-bf84-45cd-a2f4-18433cc8eb58";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/AF28-318C";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/a9797a4a-3c40-410b-8407-c70730c1cae3";
      fsType = "ext4";
    };

  fileSystems."/home/disk" =
    { device = "/dev/disk/by-uuid/509ABDD09ABDB338";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000" "gid=100" ];
    };
  
  fileSystems."/home/common_files" =
    { device = "/dev/disk/by-uuid/7ee33afb-31af-4e53-a402-bda356e7a4c4";
      fsType = "ext4"; 
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/1803425b-5e21-443d-9fd1-c76f84ece624"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
