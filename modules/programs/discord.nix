{ config, pkgs, ... }@inputs:
{
  hm.programs.vesktop = {
    enable = true;
    package = pkgs.vesktop;
  };
}
