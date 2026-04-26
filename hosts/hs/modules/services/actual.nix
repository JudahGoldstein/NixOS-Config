{ config, pkgs, ... }@inputs:
{
  services.actual = {
    enable = true;
    openFirewall = true;
    settings = {
      hostname = "127.0.0.1";
      port = 6583;
      dataDir = "/var/lib/actual";
    };
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "actual" 6583);
}
