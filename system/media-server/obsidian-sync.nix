{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.couchdb = {
      enable = true;
      port = 5984;
      adminUser = "admin";
      # Set adminPassword manually in `/var/lib/couchdb/local.ini` until i can figure out how to use sops for it 
    };
    services.caddy.virtualHosts."couchdb.ts.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:5984
      '';
    };
    services.caddy.virtualHosts."couchdb.wan.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:5984
      '';
    };
    services.caddy.virtualHosts."couchdb.local.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:5984
      '';
    };
  };
}