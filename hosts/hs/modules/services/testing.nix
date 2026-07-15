{ config, pkgs, ... }@inputs:
{
  services.static-web-server ={
    enable = true;
    root = "/home/${config.name}/testing";
    listen = "[::]:8043";
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkPublicVirtualHost "testing" 8043);
}
