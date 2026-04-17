{ config, pkgs, ... }@inputs:
{
  hm.programs.thunderbird = {
    enable = false;
    profiles."default" = {
      isDefault = true;
    };
  };
}
