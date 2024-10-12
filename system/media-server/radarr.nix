{ config, pkgs, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.radarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/radarr";
    };
  };
}
