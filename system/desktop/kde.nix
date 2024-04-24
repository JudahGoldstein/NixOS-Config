{ config, pkgs, lib, ... }:
{
    options = {
        kde.enable = lib.mkEnableOption "kde";
    };
    config =  lib.mkIf config.kde.enable {
        services.displayManager.sddm.enable = true;
        services.desktopManager.plasma6.enable = true;

    services.xserver.displayManager.defaultSession = "plasmax11";
    services.xserver.displayManager.sddm.wayland.enable = false;
    environment.plasma6.excludePackages = with pkgs.kdePackages;
    [
    konsole
    elisa
    kwrite
    kwalletmanager
    ];

    };
}
