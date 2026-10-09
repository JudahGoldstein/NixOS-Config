{ config, pkgs, ... }@inputs:
{
  services.gitea = {
    enable = false;
    settings = {
      server = {
      	ROOT_URL = "https://git.wan.janjuta.org/";
        DISABLE_SSH = true;
        HTTP_PORT = 6982;
      };
      service.DISABLE_REGISTRATION = true;
      session.COOKIE_SECURE = true;
    };
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "git" 6982);
}
