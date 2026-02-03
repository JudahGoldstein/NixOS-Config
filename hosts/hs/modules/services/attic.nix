{ config, pkgs, ... }@inputs:
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "atticd" ];
    ensureUsers = [
      {
        name = "atticd";
        ensureDBOwnership = true;
      }
    ];
  };
  services.atticd = {
    enable = true;
    environmentFile = "/var/lib/secrets/attic-secret";
    settings = {
      listen = "127.0.0.1:6277";
      database.url = "postgresql:///atticd?host=/run/postgresql";
      max-nar-info-size = 5 * 1048576; # 5 MiB
      chunking = {
        nar-size-threshold = 64 * 1024; # 64 KiB
        min-size = 16 * 1024; # 16 KiB
        avg-size = 64 * 1024; # 64 KiB
        max-size = 256 * 1024; # 256 KiB
      };
    };
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "attic" 6277);
}
