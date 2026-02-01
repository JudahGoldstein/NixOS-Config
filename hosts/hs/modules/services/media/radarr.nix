{ config, pkgs, ... }@inputs:
{
  services.radarr = {
    enable = true;
    openFirewall = true;
    group = "media";
    dataDir = "/var/lib/radarr";
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "radarr" 7878);
}
