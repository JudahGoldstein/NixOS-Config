{ config, pkgs, ... }@inputs:
{
  services.gitea = {
    enable = true;
    settings.server.DISABLE_SSH = true;
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "git" 6982);
}
