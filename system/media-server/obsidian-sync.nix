{ config, pkgs, lib, ... }:
let
  virtualHosts = import ../caddy/virtualHosts.nix { inherit lib; };
in
with lib;
{
  config = mkIf config.media-server.enable {
    services.couchdb = {
      enable = true;
      port = 5984;
      adminUser = "admin";
      # Set adminPassword manually in `/var/lib/couchdb/local.ini` until i can figure out how to use sops for it 
    };
    services.caddy.virtualHosts = (virtualHosts.mkPublicVirtualHost "couchdb" 5984);
  };
}
