{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../../../../helpers/virtualHosts.nix inputs;
in
{
  config = {
    services.prowlarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/prowlarr";
      package = pkgs.prowlarr;
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "prowlarr" 9696);
  };
}
