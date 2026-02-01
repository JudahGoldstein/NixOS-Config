{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../../../../helpers/virtualHosts.nix inputs;
in
{
  config = {
    services.radarr = {
      enable = true;
      openFirewall = true;
      group = "media";
      dataDir = "/var/lib/radarr";
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "radarr" 7878);
  };
}
