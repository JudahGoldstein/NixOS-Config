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
  };
}
