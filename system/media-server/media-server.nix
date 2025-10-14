{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./sonarr.nix
      ./radarr.nix
      ./prowlarr.nix
      ./flaresolverr.nix
      ./jellyfin.nix
      ./obsidian-sync.nix
      ./copyparty.nix
    ];
  options = {
    media-server.enable = lib.mkOption {
      default = false;
      description = "Enable the media server services";
    };
  };

  config = lib.mkIf config.media-server.enable {
    environment.systemPackages = with pkgs;
      [
        recyclarr
        czkawka-full
      ];
    torrent.enable = true;
    caddy.enable = true;
  };
}
