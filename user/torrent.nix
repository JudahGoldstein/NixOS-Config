{ config, pkgs, lib, ... }:
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
      dataDir = "/var/lib/rtorrent";
      downloadDir = "/mnt/media/Downloads";
    };
    services.flood = {
      enable = true;
      openFirewall = true;
    };
  };
}
