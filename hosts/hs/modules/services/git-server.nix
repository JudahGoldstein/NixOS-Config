{ config, pkgs, ... }@inputs:
{
  services.gitea = {
    enable = true;
    settings.server = {
      DISABLE_SSH = true;
      HTTP_PORT = 6982;
    };
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "git" 6982);
}
