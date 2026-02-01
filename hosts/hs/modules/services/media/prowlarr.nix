{ config, pkgs, ... }@inputs:
{
  services.prowlarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/prowlarr";
    package = pkgs.prowlarr;
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "prowlarr" 9696);
}
