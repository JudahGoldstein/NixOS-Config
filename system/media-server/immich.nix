{ config, pkgs, lib, ... }:
let
  virtualHosts = import ../caddy/virtualHosts.nix { inherit lib; };
in
with lib;
{
  config = mkIf config.media-server.enable {
    services.immich = {
      enable = true;
      port = 58278;
      host = "0.0.0.0";
      openFirewall = true;
      machine-learning.enable = false;
      accelerationDevices = null;
      package = pkgs.immich;
      settings = null;
    };
    services.caddy.virtualHosts = (virtualHosts.mkPublicVirtualHost "immich" 58278);
  };
}
