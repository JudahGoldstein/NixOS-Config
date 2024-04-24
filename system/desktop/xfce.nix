{ config, pkgs, lib, ... }:
{
    options = {
        xfce.enable = lib.mkEnableOption "xfce";
    };
    config =  lib.mkIf config.xfce.enable {
        services.displayManager.sddm.enable = true;
        services.xserver.desktopManager.xfce.enable = true;
    };
}
