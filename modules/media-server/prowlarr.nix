{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../helpers/virtualHosts.nix inputs;
in
{
  config = inputs.lib.mkIf config.media-server.enable {
    services.prowlarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/prowlarr";
      package = pkgs.prowlarr;
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "prowlarr" 9696);
  };
}
