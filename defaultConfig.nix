{ config, pkgs, lib, ... }:
with lib;
{
  imports =
    [
      ./system/networking.nix
      ./system/localization.nix
      ./system/io.nix
      ./system/sh.nix
      ./system/packages.nix
      ./system/desktop/desktop.nix
      ./system/battery.nix
      ./system/obs.nix
      ./system/nh.nix
      ./system/logitech.nix
      ./system/keyboard.nix
      ./system/nvidia-prime.nix
      ./system/gaming.nix
      ./system/blocky/blocky.nix
      ./system/arr.nix
      ./system/sops.nix
      ./system/user.nix
      ./system/nix-ld.nix
      ./system/media-server/media-server.nix
      ./system/torrent.nix
      ./system/docker.nix
      ./system/wireguard.nix
      ./system/caddy.nix
    ];
  options = {
    name = mkOption {
      type = types.str;
      default = "";
    };
  };

}
