{ config, pkgs, ... }@inputs:
{
  services.sonarr = {
    enable = true;
    openFirewall = true;
    group = "media";
    dataDir = "/var/lib/sonarr";
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "sonarr" 8989);
}
