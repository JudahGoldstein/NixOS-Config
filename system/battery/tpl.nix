{ config, pkgs, lib, ... }:
with lib;
{
    options = {
        tpl.enable = mkEnableOption "enable tpl";
    };

    config = mkIf config.tpl.enable {
        powerManagement.enable = true;
        services.power-profiles-daemon.enable = false;
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