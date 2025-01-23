{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    environment.systemPackages = with pkgs-unstable; [ stash ];
    networking.firewall = #stash port
      {
        allowedTCPPorts = [ 9049 ];
        allowedUDPPorts = [ 9049 ];
      };
    systemd.services.stash = {
      enable = true;
      description = "stash";
      wantedBy = [ "default.target" ];
      after = [ "network.target" ];
      unitConfig.type = "simple";
      path = [ "/mnt/media/Bulk/stash/" ];
      serviceConfig = {
        ExecStart = "${pkgs-unstable.stash}/bin/stash --port 9049 -c /mnt/media/Bulk/stash/config.yml";
        Restart = "always";
        RestartSec = 30;
        StartLimitBurst = 6;
      };
    };
    services.caddy.virtualHosts."stash.janjuta.duckdns.org" = {
      useACMEHost = "janjuta.duckdns.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:9049
      '';
    };
    services.caddy.virtualHosts."stash.jantun.duckdns.org" = {
      useACMEHost = "jantun.duckdns.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:9049
      '';
    };
  };
}
