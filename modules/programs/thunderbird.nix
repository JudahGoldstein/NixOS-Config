{ config, pkgs, ... }@inputs:
{
  hm.programs.thunderbird = {
    enable = true;
    profiles."default" = {
      isDefault = true;
    };
    package = pkgs.thunderbird-bin;
  };
}
