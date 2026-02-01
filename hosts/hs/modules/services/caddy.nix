{ config, pkgs, ... }@inputs:
{
  networking.firewall.allowedTCPPorts = inputs.lib.mkIf config.services.caddy.enable [
    80
    443
  ];
  security.acme = inputs.lib.mkIf config.services.caddy.enable {
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
    enable = inputs.lib.mkDefault false;
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
}
