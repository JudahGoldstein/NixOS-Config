{ config, pkgs, ... }@inputs:
{
  services.gitea = {
    enable = true;
    settings.server = {
      DISABLE_SSH = true;
      PROTOCOL = "https";
      DOMAIN = "git.ts.janjuta.org";
      HTTP_PORT = 6982;
      ROOT_URL = "${config.services.gitea.settings.server.PROTOCOL}://${config.services.gitea.settings.server.DOMAIN}/";
    };
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "git" 6982);
}
