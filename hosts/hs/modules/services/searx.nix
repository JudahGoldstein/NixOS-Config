{ config, pkgs, ... }@inputs:
{
  services.searx = {
    enable = true;
    settings.server = {
      bind_address = "::1";
      port = 6578;
      secret_key = config.sops.secrets.searx-secret.path;
    };
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "search" 6578);
}
