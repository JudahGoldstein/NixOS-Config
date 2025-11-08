{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../helpers/virtualHosts.nix inputs;
in
{
  config = inputs.lib.mkIf config.media-server.enable {
    services.radarr = {
      enable = true;
      openFirewall = true;
      group = "media";
      dataDir = "/var/lib/radarr";
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "radarr" 7878);
  };
}
