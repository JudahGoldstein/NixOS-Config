{ config, pkgs, lib, stable-diffusion-webui-nix, ... }:
with lib;
{
  options = {
    forge.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Forge AI";
    };
  };
  config = mkIf config.forge.enable {
    nixpkgs.overlays = [ stable-diffusion-webui-nix.overlays.default ];
    environment.systemPackages = [ pkgs.stable-diffusion-webui.forge.cuda ];
  };
}
