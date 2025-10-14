{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../caddy/virtualHosts.nix inputs;
in
{
  config = inputs.lib.mkIf config.media-server.enable {
    services.sonarr = {
      enable = true;
      openFirewall = true;
      group = "users";
      dataDir = "/var/lib/sonarr";
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "sonarr" 8989);
  };
}
