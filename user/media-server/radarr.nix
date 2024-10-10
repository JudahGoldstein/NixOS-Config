{ config, pkgs, lib, ... }:
with lib;
{
  config = mkIf media-server.enable {
    services.radarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/radarr";
    };
  };
}
