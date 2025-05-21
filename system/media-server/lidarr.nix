{ config, pkgs, lib, ... }:
let
  virtualHosts = import ../caddy/virtualHosts.nix { inherit lib; };
in
with lib;
{
  config = mkIf config.media-server.enable {
    services.lidarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/lidarr";
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "lidarr" 8686);
  };
}
