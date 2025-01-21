{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    forge.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Forge AI";
    };
  };
  config = mkIf config.forge.enable {
    nixpkgs.overlays = [ stable-diffusion-webui-nix.overlays.default ];
    environment.systemPackages = [ pkgs.stable-diffusion-webui.forge.cuda ];
  };
}
