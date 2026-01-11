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
    caddy.enable = true;
    torrent.enable = true;
    services.caddy.virtualHosts = (
      virtualHosts.mkLocalVirtualHost "deluge" config.services.deluge.port
    );
  };
}
