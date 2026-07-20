{ config, pkgs, ... }@inputs:
{
  services.gitea = {
    enable = true;
    settings = {
      server = {
        DISABLE_SSH = true;
        HTTP_PORT = 6982;
      };
      service.DISABLE_REGISTRATION = true;
      session.COOKIE_SECURE = true;
    };
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkPublicVirtualHost "git" 6982);
}
