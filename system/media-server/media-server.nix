{ config, pkgs, lib, ... }:
with lib;
{
  imports =
    [
      ./sonarr.nix
      ./radarr.nix
      ./prowlarr.nix
      ./jellyfin.nix
      ./obsidian-sync.nix
    ];
  options = {
    media-server.enable = mkOption {
      default = false;
      description = "Enable the media server services";
    };
  };

  config = mkIf config.media-server.enable {
    environment.systemPackages = with pkgs;
      [
        recyclarr
        czkawka-full
      ];
    torrent.enable = true;
    caddy.enable = true;
  };
}
