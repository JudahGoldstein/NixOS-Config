{ config, pkgs, ... }@inputs:
{
  services.caddy.virtualHosts."comparedoc.wan.janjuta.org" = {
    useACMEHost = "janjuta.org";
    extraConfig = 
    ''root * /home/${config.name}/testing
      encode gzip
      file_server {
        hide .git
      }
    '';
    };
}
