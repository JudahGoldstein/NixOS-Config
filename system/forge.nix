{ config, pkgs, stable-diffusion-webui-nix, lib, ... }:
let
  virtualHosts = import ./caddy/virtualHosts.nix { inherit lib; };
in
with lib;
{
  options = {
    services.sd-webui-forge.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the Stable Diffusion WebUI Forge service.";
    };
  };
  config = lib.mkIf config.services.sd-webui-forge.enable {
    services.sd-webui-forge = {
      enable = true;
      user = "sd-webui-forge";
      group = "sd-webui-forge";
      dataDir = "/var/lib/sd-webui-forge";
      package = pkgs.stable-diffusion-webui.forge.cuda;
      listen = true;
      port = 7860;
      extraArgs = "--cuda-malloc";
    };

    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "forge" 7860);
  };
}
