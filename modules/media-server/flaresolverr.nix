{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../helpers/virtualHosts.nix inputs;
in
{
  config = inputs.lib.mkIf config.media-server.enable {
    services.flaresolverr = {
      enable = true;
      openFirewall = true;
      port = 8191;
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "flaresolverr" 8191);
  };
}
