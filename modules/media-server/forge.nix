{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../helpers/virtualHosts.nix inputs;
in
{
  config = inputs.lib.mkIf config.media-server.enable {
    services.sd-webui-forge = {
      enable = true;
      dataDir = "/var/lib/sd-webui";
      package = pkgs.stable-diffusion-webui.forge.cuda;
      port = 7860;
      user = "sd-webui-forge";
      group = "users";
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "forge" 7860);
  };
}
