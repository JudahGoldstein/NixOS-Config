{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{

  options = {
    torrent.enable = mkOption {
      default = false;
      description = "Enable the torrent service.";
    };
  };
  config = mkIf config.torrent.enable {

    services.transmission = {
      enable = true;
      openFirewall = true;
      openRPCPort = true;
      openPeerPorts = true;
      downloadDirPermissions = "777";
      settings = {
        download-dir = "/mnt/media/Downloads";
        incomplete-dir-enabled = false;
        watch-dir-enabled = false;
        peer-port = 50000;
        umask = 0;
      };
      settings = {
        "rpc-host-whitelist" = "*";
        "rpc-host-whitelist-enabled" = true;
        "cache-size-mb" = 64;
        "peer-limit-global" = 500;
        "peer-limit-per-torrent" = 100;
        "ratio-limit" = 1.1;
        "ratio-limit-enabled" = true;
        "idle-seeding-limit-enabled" = false;
      };
      credentialsFile = "/var/lib/secrets/transmission-credentials.json";
    };

    services.caddy.virtualHosts."transmission.janjuta.duckdns.org" = {
      useACMEHost = "janjuta.duckdns.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:9091
      '';
    };
  };
}
