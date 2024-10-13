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
    services.rtorrent = {
      enable = true;
      openFirewall = true;
      port = 5000;
      dataDir = "/var/lib/rtorrent";
      downloadDir = "/mnt/media/Downloads";
      configText = ''
        group.seeding.ratio.enable =
        group2.seeding.ratio.min.set = 110
        group2.seeding.ratio.max.set = 200
      '';
    };

    environment.systemPackages = with pkgs;[ flood ];
    systemd.services.flood = {
      description = "Flood rtorrent web interface";
      after = [ "network.target" "rtorrent.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.flood}/bin/flood";
        User = "root";
        Group = "root";
        Restart = "always";
        Environment = "NODE_ENV=production";
      };
    };
  };
}
