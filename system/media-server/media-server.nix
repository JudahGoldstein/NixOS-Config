{ config, pkgs, lib, ... }:
with lib;
{
  imports =
    [
      ./sonarr.nix
      ./radarr.nix
      ./prowlarr.nix
      ./jellyfin.nix
      ./stash.nix
    ];
  options = {
    media-server.enable = mkOption {
      default = false;
      description = "Enable the media server services";
    };
  };

  config = mkIf config.media-server.enable {
    torrent.enable = true;
    caddy.enable = true;
  };
}
