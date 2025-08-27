{ config, pkgs, lib, ... }:
let
  virtualHosts = import ../caddy/virtualHosts.nix { inherit lib; };
in
with lib;
{
  config = mkIf config.media-server.enable {
    services.sonarr = {
      enable = true;
      openFirewall = true;
      group = "users";
      dataDir = "/var/lib/sonarr";
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "sonarr" 8989);
  };
}
