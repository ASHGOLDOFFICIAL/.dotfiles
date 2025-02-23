{ config, pkgs, pkgsStable, pkgsUnstable, lib, ... }@args:

{
  services.flatpak = {
    enable = true;
    packages = [
      "com.jetbrains.IntelliJ-IDEA-Community"
      "com.jetbrains.PyCharm-Community"
      "com.jetbrains.Rider"
    ];
    overrides = {
      "com.jetbrains.IntelliJ-IDEA-Community".Context.filesystems = [
        "${pkgs.host-spawn}:ro"
        "/run/user/1000/docker.sock"
      ];
      "com.jetbrains.PyCharm-Community".Context.filesystems = [
        "${pkgs.host-spawn}:ro"
        "/run/user/1000/docker.sock"
      ];
      "com.jetbrains.Rider".Context.filesystems = [
        "${pkgs.host-spawn}:ro"
        "/run/user/1000/docker.sock"
      ];
    };
    uninstallUnmanaged = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };

  systemd.user.tmpfiles.rules = [
    "L %h/.var/app/com.jetbrains.IntelliJ-IDEA-Community/.local/bin/host-spawn - - - - ${pkgs.host-spawn}/bin/host-spawn"
  ];
}