{ config, pkgs, lib, ... }:
{
imports =
    [
    ./gnome.nix
    ];

    gnome.enable = lib.mkDefault false;
}