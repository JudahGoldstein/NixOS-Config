{ config, pkgs, lib, ... }:
with lib;
{
  options =
    {
      battery.enable = {
        type = types.bool;
        default = true;
        description = "Enable TLP power management";
      };
    };

  config = lib.mkIf (config.battery.enable == true) {
    powerManagement.enable = true;
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      };
    };
  };
}
