{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../helpers/virtualHosts.nix inputs;
in
{
  config = inputs.lib.mkIf config.media-server.enable {
    services.sd-webui-forge = {
      enable = true;
      dataDir = "/var/lib/sd-webui-forge";
      package = pkgs.stable-diffusion-webui.forge.cuda;
      port = 7860;
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "forge" 7860);
  };
}
