{ config, pkgs, ... }@inputs:
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    dataDir = "/var/lib/postgresql";
    ensureDatabases = [ "demo" ];
    ensureUsers = [
      {
        name = "demo";
        ensureDBOwnership = true;
        ensureClauses = {
          login = true;
          password = "SCRAM-SHA-256$4096:PHtEuGcogcN9LbAGYcxtPA==$GCASxLg+1WbhBfo5S1zKa4gZMixJEghobwBnhrk0JVk=:lRAe3Wxr5nb3veyq7nygE3PT9heNog3gB7u7q5DI5f4=";
        };
      }
    ];
    enableTCPIP = true;
    settings.port = 4380;
    authentication = pkgs.lib.mkOverride 10 ''
      #type  database  user  address   method
      local  all       all             trust
      host   sameuser  all   0.0.0.0/0 scram-sha-256
    '';
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkPublicVirtualHost "demo" 4380);
}
