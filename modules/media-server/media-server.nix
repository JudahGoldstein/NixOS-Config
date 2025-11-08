{ config, pkgs, ... }@inputs:
{
  options = {
    media-server.enable = inputs.lib.mkOption {
      default = false;
      description = "Enable the media server services";
    };
  };

  config = inputs.lib.mkIf config.media-server.enable {
    users.groups.media = {};
    environment.systemPackages = with pkgs; [
      recyclarr
      czkawka-full
    ];
    torrent.enable = true;
    caddy.enable = true;
  };
}
