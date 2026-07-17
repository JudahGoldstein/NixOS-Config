{ config, pkgs, ... }@inputs:
{
  hm.programs.vesktop = {
    enable = true;
    package = inputs.pkgs-insecure.vesktop;
  };
}
