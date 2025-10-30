{ config, pkgs, ... }@inputs:
{
  config = {
    programs.firefox = {
      enable = true;
      package = inputs.pkgs-stable.firefox;
    };
  };
}
