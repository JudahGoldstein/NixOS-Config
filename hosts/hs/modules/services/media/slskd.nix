{ config, pkgs, ... }@inputs:
{
  services.slskd = {
    enable = true;
    settings.web.port = 5030;
    openFirewall = true;
    settings.shares.directories = [
      "/mnt/media/soulsync/"
    ];
    settings.remote_file_management = true;
    group = "media";
    environmentFile = inputs.config.sops.secrets."slskd-env".path;
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "slskd" 5030);
}
