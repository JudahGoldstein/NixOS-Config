{ config, pkgs, ... }@inputs:
{
  services.harmonia-dev = {
    daemon.enable = true;
    cache = {
      enable = true;
      signKeyPaths = [ "/var/lib/secrets/harmonia.secret" ];
      settings = {
        bind = "[::]:5000";
        workers = 8;
        max_connection_rate = 512;
        priority = 30;
      };
    };
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "cache" 5000);
}
