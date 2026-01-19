{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../../helpers/virtualHosts.nix inputs;
in
{
  services.atticd = {
    enable = true;
    environmentFile = "/var/lib/secrets/attic-secret";
    settings.listen = "127.0.0.1:6277";
    user = "atticd";
    group = "atticd";
  };
  services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "attic" 6277);
}
