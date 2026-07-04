{ config, pkgs, ... }@inputs:
{
  services.trilium-server = {
    enable = true;
    port = 55685;
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "write" 55685);
}
