{ config, pkgs, lib, ... }:
with lib;
{
  imports =
    [
      ./system/networking.nix
      ./system/ssh.nix
      ./system/localization.nix
      ./system/io.nix
      ./system/sh.nix
      ./system/packages.nix
      ./system/antivirus.nix
      ./system/desktop/desktop.nix
      ./system/battery.nix
      ./system/obs.nix
      ./system/nh.nix
      ./system/logitech.nix
      ./system/keyboard.nix
      ./system/gaming.nix
      ./system/blocky.nix
      ./system/sops.nix
      ./system/user.nix
      ./system/nix-ld.nix
      ./system/media-server/media-server.nix
      ./system/torrent.nix
      ./system/docker.nix
      ./system/wireguard.nix
      ./system/caddy/caddy.nix
      ./system/ollama.nix
      ./system/firefox.nix
      ./system/terminal.nix
      ./system/dev.nix
      ./system/text-editors.nix
      ./system/audio-video.nix
      ./system/forge.nix
    ];

  options = {
    name = mkOption {
      type = types.str;
      description = "The hostname for this configuration";
    };
  };

  config = {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    services.fstrim.enable = true;
    nixpkgs.config.allowUnfree = true;

    # Common nix-ld configuration for unpackaged programs
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
    ];
    system.stateVersion = "23.11";
  };
}
