{ config, pkgs, ... }@inputs:
{
  services.slskd = {
    enable = true;
    settings.web.port = 5030;
    openFirewall = true;
    settings.shares.directories = [
      "/mnt/media/soulsync"
    ];
    settings.remote_file_management = true;
    environmentFile = inputs.config.sops.secrets."slskd-env".path;
    user = "music";
    group = "media";
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "slskd" 5030);
}
