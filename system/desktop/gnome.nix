{ config, pkgs, lib, ... }:
{
    options = {
        gnome.enable = {
            lib.mkEnableOption "gnome";
            lib.mkDefault false;
        };
    };
    config = lib.mkIf config.gnome.enable{
        services.xserver.displayManager.gdm.enable = true;
        services.xserver.desktopManager.gnome.enable = true;
    };
}
