{ config, pkgs, lib, ... }:
let
  virtualHosts = import ../caddy/virtualHosts.nix { inherit lib; };
in
with lib;
{
  config = mkIf config.media-server.enable {

    services.immich = {
      enable = true;
      port = 2283;
      openFirewall = true;
      machine-learning.enable = false;
      accelerationDevices = null;
      package = pkgs.immich;
      settings = null;
    };
    services.caddy.virtualHosts = (virtualHosts.mkPublicVirtualHost "images" 2283);
  };
}
