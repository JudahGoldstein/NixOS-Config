{ config, pkgs, ... }:

{
    imports =
    [
    ./hardware-configuration.nix
    ./bootloader.nix
    ../../system/networking.nix
    ../../system/localization.nix
    ../../system/io.nix
    ../../system/sh.nix
    ../../system/packages.nix
    ../../system/users.nix
    ../../system/desktop/desktop.nix
    ../../system/battery/battery.nix
	../../system/obs.nix
    ];

    programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep 3";
        flake = "/home/v14/NixOS-Config";
    };

    # Enable automatic login for the user.
    services.displayManager.autoLogin = {
        enable = false;
        user = "v14";
    };

    gnome.enable = true;

    nix.settings.experimental-features = ["nix-command" "flakes"];

    system.stateVersion = "23.11";
}
