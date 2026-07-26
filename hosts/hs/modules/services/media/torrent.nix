{ config, pkgs, ... }@inputs:
{
  networking.firewall = {
    allowedTCPPorts = [ 32085 ];
    allowedUDPPorts = [ 32085 ];
  };

  services.qbittorrent = {
    enable = true;
    group = "media";
    openFirewall = true;
    torrentingPort = 32085;
    webuiPort = 9786;
    serverConfig = {
      LegalNotice.Accepted = true;
      BitTorrent.Session = {
        DefaultSavePath = "/mnt/media/Downloads";
        TempPath = "/var/lib/qBittorrent/qBittorrent/downloads";
        TempPathEnabled = true;
        GlobalMaxRatio = 1.1;
        ShareLimitAction = "Stop";
        QueueingSystemEnabled = true;
        IgnoreSlowTorrentsForQueueing = true;
      };
      Preferences = {
        WebUI = {
          Username = "user";
          Password_PBKDF2 = "6SVZBBGBrDa5kzDnAdmskQ==:Q2TAacuLNVLUtKiGWXZ1vzpFO+4+ZMyK9HjD6K3HIKuNseeICKgzcTSoBF0MltULgfGBiBS/APBpK2AO8ACi1Q==";
        };
        General.Locale = "en";
      };
    };
    package = pkgs.qbittorrent-nox;
  };

  services.caddy.virtualHosts = (
    inputs.virtualHosts.mkLocalVirtualHost "qbittorrent" config.services.qbittorrent.webuiPort
  );
}
