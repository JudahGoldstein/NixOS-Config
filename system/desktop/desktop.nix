{ config, pkgs, lib, ... }:
{
    imports =
    [
    ./gnome.nix
    ./kde.nix
    ./openbox.nix
    ];

    gnome.enable = lib.mkDefault false;
    kde.enable = lib.mkDefault false;
    openbox.enable = lib.mkDefault false;

    services.xserver.enable = true;
}
