{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{

  options = {
    torrent.enable = mkOption {
      default = false;
      description = "Enable the torrent service.";
    };
    transmission.enable = mkOption {
      default = false;
      description = "Enable the Transmission torrent client.";
    };
    deluge.enable = mkOption {
      default = true;
      description = "Enable the Deluge torrent client.";
    };
  };

  config = mkIf config.torrent.enable {
    networking.firewall = #peer port
      {
        allowedTCPPorts = [ 32085 ];
        allowedUDPPorts = [ 32085 ];
      };

    services.deluge = mkIf config.deluge.enable {
      enable = true;
      openFirewall = true;
      web.enable = true;
      web.openFirewall = true;
      web.port = 8112;
    };
    services.transmission = mkIf config.transmission.enable {
      enable = true;
      openFirewall = true;
      openRPCPort = true;
      openPeerPorts = true;
      downloadDirPermissions = "777";
      settings = {
        download-dir = "/mnt/media/Downloads";
        incomplete-dir-enabled = false;
        watch-dir-enabled = false;
        peer-port = 32085;
        umask = 0;
      };
      settings = {
        "rpc-host-whitelist" = "*";
        "rpc-host-whitelist-enabled" = true;
        "cache-size-mb" = 1024;
        "peer-limit-global" = 500;
        "peer-limit-per-torrent" = 100;
        "ratio-limit" = 1.1;
        "ratio-limit-enabled" = true;
        "idle-seeding-limit" = 10080;
        "idle-seeding-limit-enabled" = false;
        "download-queue-enabled" = false;
      };
      credentialsFile = "/var/lib/secrets/transmission-credentials.json";
    };

    services.caddy.virtualHosts = {
      "transmission.janjuta.duckdns.org" = mkIf config.transmission.enable {
        useACMEHost = "janjuta.duckdns.org";
        extraConfig = ''
          reverse_proxy http://127.0.0.1:9091
        '';
      };
      "deluge.janjuta.duckdns.org" = mkIf config.deluge.enable {
        useACMEHost = "janjuta.duckdns.org";
        extraConfig = ''
          reverse_proxy http://127.0.0.1:8112
        '';
      };
    };
  };
}
