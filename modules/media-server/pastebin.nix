{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../caddy/virtualHosts.nix inputs;
in
{
  config = inputs.lib.mkIf config.media-server.enable {
    services.wastebin = {
      enable = true;
      settings.WASTEBIN_ADDRESS_PORT = "0.0.0.0:1459";
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "wastebin" 1459);
  };
}
