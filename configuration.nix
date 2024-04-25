{ config, pkgs, ... }:

{
    imports =
    [
    ./hardware-configuration.nix
    ./system/bootloader.nix
    ./system/networking.nix
    ./system/localization.nix
    ./system/io.nix
    ./system/sh.nix
    ./system/packages.nix
    ./system/users.nix
    ./system/desktop/desktop.nix
    ];

    programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 7d --keep 3";
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
