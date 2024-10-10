{ config, pkgs, lib, ... }:
with lib;
{
  config = mkIf media-server.enable {
    services.sonarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/sonarr";
    };
  };
}
