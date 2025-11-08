{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../helpers/virtualHosts.nix inputs;
in
{
  options = {
    torrent.enable = inputs.lib.mkOption {
      default = false;
      description = "Enable the torrent service.";
    };
  };

  config = inputs.lib.mkIf config.torrent.enable {
    networking.firewall = # peer port
      {
        allowedTCPPorts = [ 32085 ];
        allowedUDPPorts = [ 32085 ];
      };

    services.deluge = {
      enable = true;
      group = "media";
      openFirewall = true;
      web.enable = true;
      web.openFirewall = true;
      web.port = 8112;
    };

    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "deluge" 8112);
  };
}
