{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../../helpers/virtualHosts.nix inputs;
in
{
  config = {
    services.couchdb = {
      enable = true;
      port = 5984;
      extraConfigFiles = [ config.sops.secrets."couchdb-creds".path ];
      extraConfig = {
        couchdb = {
          max_document_size = 50000000;
        };
        chttpd = {
          require_valid_user = "true";
          max_http_request_size = 4294967296;
        };
        chttpd_auth = {
          require_valid_user = "true";
        };
        httpd = {
          WWW-Authenticate = "Basic realm=\"couchdb\"";
          enable_cors = "true";
        };
        cors = {
          credentials = "true";
          origins = "app://obsidian.md,capacitor://localhost,http://localhost";
        };
      };
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "couchdb" 5984);
  };
}
