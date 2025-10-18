{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ./caddy/virtualHosts.nix inputs;
in
{
  options = {
    sd-webui-forge.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Enable the Stable Diffusion WebUI Forge.";
    };
  };
  config = inputs.lib.mkIf (config.sd-webui-forge.enable == true) {
    nixpkgs.overlays = [ inputs.stable-diffusion-webui-nix.overlays.default ];
    environment.systemPackages = with pkgs; [
      stable-diffusion-webui.forge.cuda
    ];
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "forge" 7860);
  };
}
