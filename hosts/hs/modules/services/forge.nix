{ config, pkgs, ... }@inputs:
{
  services.sd-webui-forge = {
    enable = true;
    dataDir = "/var/lib/sd-webui-forge";
    dataPermissions = "0766";
    package = pkgs.stable-diffusion-webui.forge.cuda;
    port = 7860;
    user = "sd-webui-forge";
    group = "media";
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "forge" 7860);
}
