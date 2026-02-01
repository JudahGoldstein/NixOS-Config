{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../../../../helpers/virtualHosts.nix inputs;
in
{
  config = {
    services.flaresolverr = {
      enable = true;
      openFirewall = true;
      port = 8191;
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "flaresolverr" 8191);
  };
}
