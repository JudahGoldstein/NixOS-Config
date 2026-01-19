{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../../helpers/virtualHosts.nix inputs;
in
{
  services.atticd = {
    enable = true;
    environmentFile = "/var/lib/secrets/attic-secret";
    settings = {
      listen = "127.0.0.1:6277";
      chunking = {
        nar-size-threshold = 64 * 1024; # 64 KiB
        min-size = 16 * 1024; # 16 KiB
        avg-size = 64 * 1024; # 64 KiB
        max-size = 256 * 1024; # 256 KiB
      };
    };
  };
  services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "attic" 6277);
}
