{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../../../helpers/virtualHosts.nix inputs;
in
{
  config = {
    services.sd-webui-forge = {
      enable = true;
      dataDir = "/var/lib/sd-webui-forge";
      dataPermissions = "0764";
      package = pkgs.stable-diffusion-webui.forge.cuda;
      port = 7860;
      user = "sd-webui-forge";
      group = "users";
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "forge" 7860);
  };
}
