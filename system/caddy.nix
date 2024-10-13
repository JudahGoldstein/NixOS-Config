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
        dnsResolver = "jantun.duckdns.org:53";
        dnsPropagationCheck = true;
        environmentFile = "/var/lib/secrets/duckdns-token";
      };
    };
    services.caddy = {
      enable= true;
      virtualHosts."localhost".extraConfig = ''
        respond "OK"
      '';
      virtualHosts."janjuta.duckdns.org".extraConfig = ''
        respond "OK"
        tls /var/lib/acme/janjuta.duckdns.org/cert.pem /var/lib/acme/janjuta.duckdns.org/key.pem {
          protocols tls1.3
        } 
      '';
      virtualHosts."jantun.duckdns.org".extraConfig = ''
        respond "OK"
        tls /var/lib/acme/jantun.duckdns.org/cert.pem /var/lib/acme/jantun.duckdns.org/key.pem {
          protocols tls1.3
        }
        '';
      
    };
  };
}
