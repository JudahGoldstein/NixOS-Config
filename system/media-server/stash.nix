{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    environment.systemPackages = with pkgs-unstable;[ stash ];
    systemd.services.stash = {
      description = "Stash media server";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs-unstable.stash}/bin/stash -c /var/lib/stash/config/config.yml";
        User = "root";
        Group = "root";
        Restart = "always";
      };
    };
    services.caddy.virtualHosts."stash.janjuta.duckdns.org".extraConfig = ''
      reverse_proxy http://127.0.0.1:9999
      tls /var/lib/acme/janjuta.duckdns.org/cert.pem /var/lib/acme/janjuta.duckdns.org/key.pem {
        protocols tls1.3
      }
    '';
  };
}
