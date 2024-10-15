{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  options = {
    caddy.enable = mkOption {
      default = false;
      description = "Enable the caddy web server.";
    };
  };
  config = mkIf config.caddy.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    security.acme = {
      acceptTerms = true;
      defaults.email = "yehudah.lev@gmail.com";
      certs."janjuta.duckdns.org" = {
        group = config.services.caddy.group;
        domain = "janjuta.duckdns.org";
        extraDomainNames = [ "*.janjuta.duckdns.org" ];
        dnsProvider = "duckdns";
        dnsResolver = "jantun.duckdns.org:53";
        dnsPropagationCheck = true;
        environmentFile = "/var/lib/secrets/duckdns-token";
      };
      certs."jantun.duckdns.org" = {
        group = config.services.caddy.group;
        domain = "jantun.duckdns.org";
        extraDomainNames = [ "*.jantun.duckdns.org" ];
        dnsProvider = "duckdns";
        dnsPropagationCheck = true;
        environmentFile = "/var/lib/secrets/duckdns-token";
      };
    };
    services.caddy = {
      enable = true;
      group = "caddy";
      user = "caddy";
      virtualHosts."janjuta.duckdns.org" = {
        useACMEHost = "janjuta.duckdns.org";
        extraConfig = ''
          respond "OK"
        '';
      };
      virtualHosts."jantun.duckdns.org" = {
        useACMEHost = "jantun.duckdns.org";
        extraConfig = ''
          respond "OK"
        '';
      };
    };
  };
}
