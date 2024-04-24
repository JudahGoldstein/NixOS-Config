{ config, pkgs, lib, ... }:
{
    options = {
        openbox.enable = lib.mkEnableOption "openbox";
    };
    config =  lib.mkIf config.openbox.enable {
        services.displayManager.sddm.enable = true;
        services.xserver.windowManager.openbox.enable = true;
    };
}

