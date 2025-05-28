{ config, pkgs, lib, ... }:
let
  virtualHosts = import ../caddy/virtualHosts.nix { inherit lib; };
in
with lib;
{
  config = mkIf config.media-server.enable {
    docker.enable = true;
    virtualisation.oci-containers.containers = {
      deemix = {
        image = "ghcr.io/bambanah/deemix:latest";
        ports = [ "6595:6595" ];
        volumes = [
          "/var/lib/deemix:/config"
          "/mnt/media/Music:/downloads"
        ];
        environment = {
          DEEMIX_SERVER_PORT = "6595";
          DEEMIX_MUSIC_DIR = "/downloads";
          DEEMIX_DATA_DIR = "/config";        };
      };
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "deemix" 6595);
  };
}
