{ config, pkgs, lib, ... }:
{
    imports =
    [
    ./gnome.nix
    ./kde.nix
    ];

    gnome.enable = lib.mkDefault false;
    kde.enable = lib.mkDefault false;

    services.xserver.enable = true;
}
