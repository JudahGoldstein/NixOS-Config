{ config, pkgs, pkgs-pin, lib, ... }:
let
  virtualHosts = import ../caddy/virtualHosts.nix { inherit lib; };
in
with lib;
{
  config = mkIf config.media-server.enable {
    services.mealie = {
      enable = true;
      port = 41026;
      package = pkgs-pin.mealie;
    };
    
    services.caddy.virtualHosts = (virtualHosts.mkPublicVirtualHost "mealie" 41026 );
  };
}
