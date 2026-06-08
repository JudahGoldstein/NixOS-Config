{ config, pkgs, ... }@inputs:
{
  services.harmonia-dev.cache = {
    enable = true;
    signKeyPaths = [ "/var/lib/secrets/harmonia.secret" ];
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkPublicVirtualHost "cache" 5000);
}
