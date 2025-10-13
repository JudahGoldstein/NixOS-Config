{ config, pkgs, lib, ... }:
{
  options = {
    caddy.enable = lib.mkOption {
      default = false;
      description = "Enable the caddy web server.";
    };
  };
  config = lib.mkIf config.caddy.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    security.acme = {
      acceptTerms = true;
      defaults = {
        email = "yehudah.lev@gmail.com";
        dnsResolver = "1.1.1.1:53";
        dnsProvider = "cloudflare";
        dnsPropagationCheck = true;
        environmentFile = config.sops.secrets."cloudflare-dns-api-key".path;
        group = config.services.caddy.group;
      };
      certs."janjuta.org" = {
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
