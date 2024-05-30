{ config, pkgs, lib, ... }:
with lib;
{
  options =
    {
      tlp.enable = {
        type = types.bool;
        default = true;
        description = "Enable TLP power management";
      };

      power-profiles.enable = {
        type = types.bool;
        default = false;
        description = "Enable power-profiles-daemon";
      };

    };

  config = {
    powerManagement.enable = if ((config.tlp.enable == true) or (config.power-profiles.enable == true)) then true else false;
    services.power-profiles-daemon.enable = if ((config.power-profiles.enable == true) and (config.tpl.enable == false)) == true then true else false;
    services.tlp =
      if (config.tlp.enable == true) then {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        };
      } else {
        enable = false;
      };
  };
}
