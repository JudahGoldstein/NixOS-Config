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
      defaults = {
        email = "yehudah.lev@gmail.com";
        dnsResolver = "1.1.1.1:53";
        dnsProvider = "duckdns";
        dnsPropagationCheck = true;
        environmentFile = "/var/lib/secrets/duckdns-token";
        group = config.services.caddy.group;
      };
      certs."janjuta.duckdns.org" = {
        domain = "janjuta.duckdns.org";
        extraDomainNames = [ "*.janjuta.duckdns.org" ];
      };
      certs."jantun.duckdns.org" = {
        domain = "jantun.duckdns.org";
        extraDomainNames = [ "*.jantun.duckdns.org" ];
      };
      certs."janjuta.org" = {
        dnsProvider = "cloudflare";
        environmentFile = "/var/lib/secrets/cloudflare-dns-api-key";
        domain = "janjuta.org";
        extraDomainNames = [
          "local.janjuta.org"
          "wan.janjuta.org"
          "ts.janjuta.org"
          "*.local.janjuta.org"
          "*.wan.janjuta.org"
          "*.ts.janjuta.org"
        ];
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
      virtualHosts."janjuta.org" = {
        useACMEHost = "janjuta.org";
        extraConfig = ''
          respond "OK"
        '';
      };
      virtualHosts."ts.janjuta.org" = {
        useACMEHost = "janjuta.org";
        extraConfig = ''
          respond "OK"
        '';
      };
      virtualHosts."local.janjuta.org" = {
        useACMEHost = "janjuta.org";
        extraConfig = ''
          respond "OK"
        '';
      };
    };
  };
}
