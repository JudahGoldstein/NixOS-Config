{ config, pkgs, lib, ... }:
let
  virtualHosts = import ../caddy/virtualHosts.nix { inherit lib; };
in
{
  config = lib.mkIf config.media-server.enable {
    services.flaresolverr = {
      enable = true;
      openFirewall = true;
      port = 8191;
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "flaresolverr" 8191);
  };
}
