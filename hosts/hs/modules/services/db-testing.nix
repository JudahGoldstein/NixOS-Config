{ config, pkgs, ... }@inputs:
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
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
    settings = {
      port = 4380;
      ssl = "on";
      ssl_cert_file = "/var/lib/acme/janjuta.org/fullchain.pem";
      ssl_key_file = "/var/lib/acme/janjuta.org/key.pem";
    };
    authentication = pkgs.lib.mkOverride 10 ''
      #type    database  user  address   method
      local    all       all             trust
      hostssl  sameuser  all   0.0.0.0/0 scram-sha-256
    '';
  };

  users.users.postgres.extraGroups = [ "caddy" ];

  networking.firewall.allowedTCPPorts = [ 4380 ];

  security.acme.certs."janjuta.org".postRun = "systemctl restart postgresql";
}