{ config, pkgs, ... }@inputs:
{
  services.harmonia-dev = {
    daemon.enable = true;
    cache = {
      enable = true;
      signKeyPaths = [ "/var/lib/secrets/harmonia.secret" ];
    };
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "cache" 5000);
}
