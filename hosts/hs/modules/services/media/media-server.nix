{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    czkawka-full
  ];
  services.deluge.enable = true;
  services.caddy.virtualHosts = (
    inputs.virtualHosts.mkLocalVirtualHost "deluge" config.services.deluge.web.port
  );
}
