{ config, pkgs, lib, ... }:
with lib;
{
  imports = if config.media-server.enable then
  [
    ./sonarr.nix
    ./radarr.nix
    ./prowlarr.nix
    ./jellyfin.nix
  ] else [];
  options = {
    media-server.enable = mkOption {
      default = false;
      description = "Enable the media server services";
    };
  };

  config = mkIf config.media-server.enable {
    torrent.enable = true; # Enable the torrent service
  };
}