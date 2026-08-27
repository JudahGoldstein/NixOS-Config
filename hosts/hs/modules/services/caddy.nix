{ config, pkgs, ... }@inputs:
{
  networking.firewall.allowedTCPPorts = inputs.lib.mkIf config.services.caddy.enable [
    80
    443
  ];
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
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/mholt/caddy-l4@v0.1.2" ];
      hash = "sha256-UIv8PxtJMlX7qClnPazFsSSl7G1BzsTT8VjrMIfB46Q=";
    };
    group = "caddy";
    user = "caddy";
    globalConfig = ''
      servers {
        listener_wrappers {
          layer4 {
            @db-tls tls {
              alpn postgresql
              sni demo.wan.janjuta.org
            }
            route @db-tls {
              tls {
                connection_policy {
                  alpn postgresql
                }
              }
              proxy 127.0.0.1:4380
            }
          }
          tls
        }
      }
    '';
    virtualHosts."demo.wan.janjuta.org" = {
      useACMEHost = "janjuta.org";
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
}
