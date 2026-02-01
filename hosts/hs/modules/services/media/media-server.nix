{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../../helpers/virtualHosts.nix inputs;
in
{
  config = {
    environment.systemPackages = with pkgs; [
      recyclarr
      czkawka-full
    ];
    services.caddy.enable = true;
    services.deluge.enable = true;
    services.caddy.virtualHosts = (
      virtualHosts.mkLocalVirtualHost "deluge" config.services.deluge.web.port
    );
  };
}
