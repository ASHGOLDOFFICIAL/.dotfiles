# Media server configuration

{ config, pkgs, lib, ... }:

let
  cfg = config.custom.server.media;
  groupName = "mediagroup";
  mediaDir = "/home/media";
in {
  options.custom.server.media = {
    enable = lib.mkEnableOption "media server";
  };

  config = lib.mkIf cfg.enable {
    services = {
      jellyfin = {
        enable = true;
        openFirewall = true;
        group = groupName;
      };
      transmission = {
        enable = true;
        package = pkgs.transmission_4;
        group = groupName;
        settings = {
          download-dir = "${mediaDir}/torrent/complete";
          incomplete-dir = "${mediaDir}/torrent/incomplete";
        };
      };
    };

    users = {
      groups.${groupName} = {};
      users.ashgoldofficial.extraGroups = [ groupName ];
    };
  };
}
