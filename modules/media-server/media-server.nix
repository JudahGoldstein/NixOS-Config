{ config, pkgs, ... }@inputs:
{
  imports = [
    ./sonarr.nix
    ./radarr.nix
    ./prowlarr.nix
    ./flaresolverr.nix
    ./jellyfin.nix
    ./obsidian-sync.nix
    ./copyparty.nix
  ];
  options = {
    media-server.enable = inputs.lib.mkOption {
      default = false;
      description = "Enable the media server services";
    };
  };

  config = inputs.lib.mkIf config.media-server.enable {
    environment.systemPackages = with pkgs; [
      recyclarr
      czkawka-full
    ];
    torrent.enable = true;
    caddy.enable = true;
  };
}
