{ config, pkgs, pkgs-stable, lib, ... }:
let
  virtualHosts = import ../caddy/virtualHosts.nix { inherit lib; };
in
with lib;
{
  config = mkIf config.media-server.enable {
    services.prowlarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/prowlarr";
      package = pkgs.prowlarr;
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "prowlarr" 9696);
  };
}
