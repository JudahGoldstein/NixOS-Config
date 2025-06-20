{ config, pkgs, lib, inputs, ... }:
let
  virtualHosts = import ./caddy/virtualHosts.nix { inherit lib; };
in
with lib;
{
  options = {
    sd-webui-forge.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the Stable Diffusion WebUI Forge.";
    };
  };
  config = lib.mkIf (config.sd-webui-forge.enable == true) {
    nixpkgs.overlays = [ inputs.stable-diffusion-webui-nix.overlays.default ];
    environment.systemPackages = with pkgs; [
      stable-diffusion-webui.forge.cuda 
    ];
      services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "forge" 7860);
  };
}
