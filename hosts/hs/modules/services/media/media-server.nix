{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    recyclarr
    czkawka-full
  ];
  services.caddy.enable = true;
  services.deluge.enable = true;
  services.caddy.virtualHosts = (
    inputs.virtualHosts.mkLocalVirtualHost "deluge" config.services.deluge.web.port
  );
}
