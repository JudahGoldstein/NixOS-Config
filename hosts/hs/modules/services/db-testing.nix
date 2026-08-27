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
    settings.port = 4380;
    authentication = pkgs.lib.mkOverride 10 ''
      #type  database  user  address   method
      local  all       all             trust
      host   sameuser  all   0.0.0.0/0 scram-sha-256
    '';
  };
  services.caddy = {
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/mholt/caddy-l4@v0.1.2" ];
      hash = "sha256-UIv8PxtJMlX7qClnPazFsSSl7G1BzsTT8VjrMIfB46Q=";
    };
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
  };
}
