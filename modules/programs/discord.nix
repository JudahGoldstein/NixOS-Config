{ config, pkgs, ... }@inputs:
{
  nixpkgs.overlays = [
    (final: _prev: {
      pnpm_10_29_2 = final.pnpm_10;
    })
  ];
  hm.programs.vesktop = {
    enable = true;
    package = pkgs.vesktop;
  };
}
