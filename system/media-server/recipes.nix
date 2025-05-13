{ config, pkgs, lib, ... }:
let
  virtualHosts = import ../caddy/virtualHosts.nix { inherit lib; };
in
with lib;
{
  config = mkIf config.media-server.enable {
    services.mealie = {
      enable = true;
      port = 41026;
    };
    
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "mealie" 41026 );
  };
}
