{ config, pkgs, ... }@inputs:
{
  services.flaresolverr = {
    enable = true;
    openFirewall = true;
    port = 8191;
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "flaresolverr" 8191);
}
