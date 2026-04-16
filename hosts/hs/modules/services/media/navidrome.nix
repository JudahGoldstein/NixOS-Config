{ config, pkgs, ... }@inputs:
{
  services.navidrome = {
    enable = true;
    settings.Port = 4533;
    settings = {
      MusicFolder = "/mnt/media/soulsync";
      PID.Album = "albumartistid,album,albumversion";
    };
    openFirewall = true;
    group = "media";
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "navidrome" 4533);
}
