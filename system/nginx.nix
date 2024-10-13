{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    nginx.enable = mkOption {
      default = false;
      description = "Enable the ngnix service.";
    };
  };
  config = mkIf config.nginx.enable {
    security.acme = {
      acceptTerms = true;
      defaults.email = "yehudah.lev@gmail.com";
      certs."janjuta.duckdns,org" = { 
        domain = "*.janjuta.duckdns.org";
        dnsProvider = "duckdns";
        environmentFile = "/etc/nixos/duckdns-token";
        dnsPropagatoinCheck = true;
      };
    };
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
    };
  };
}
