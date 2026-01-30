{ config, pkgs, ... }@inputs:
{
  networking.firewall =
    inputs.lib.mkIf config.services.deluge.enable # peer port
      {
        allowedTCPPorts = [ 32085 ];
        allowedUDPPorts = [ 32085 ];
      };

  services.deluge = {
    enable = inputs.lib.mkDefault false;
    group = "media";
    openFirewall = true;
    web.enable = true;
    web.openFirewall = true;
    web.port = 8112;
  };
}
