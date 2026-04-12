{ config, pkgs, ... }@inputs:
{
  services.slskd = {
    enable = true;
    settings.web.port = 5030;
    openFirewall = true;
    settings.directories.downloads = "/mnt/media/slskd/complete";
    settings.shares.directories = [
        "/mnt/media/slskd/complete"
        "/mnt/media/soulsync"
    ];
    group = "media";
    environmentFile = inputs.config.sops.secrets."slskd-env".path;
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "slskd" 5030);
}
