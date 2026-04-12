{ config, pkgs, ... }@inputs:
{
  services.slskd = {
    enable = true;
    settings.web.port = 5030;
    openFirewall = true;
    settings.directories = {
      complete = "/mnt/media/slskd/complete";
      incomplete = "/mnt/media/slskd/incomplete";
    };
    group = "media";
    environmentFile = inputs.config.sops.secrets."slskd-env".path;
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "slskd" 5030);
}
