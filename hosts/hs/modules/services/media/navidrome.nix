{ config, pkgs, ... }@inputs:
{
  services.navidrome = {
    enable = true;
    settings.Port = 4533;
    openFirewall = true;
    group = "media";
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "navidrome" 4533);
}
