{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../../helpers/virtualHosts.nix inputs;
in
{
  config = {
    services.sonarr = {
      enable = true;
      openFirewall = true;
      group = "media";
      dataDir = "/var/lib/sonarr";
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "sonarr" 8989);
  };
}
