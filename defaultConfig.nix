{ config, pkgs, ... }@inputs:
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
      ./system/discord.nix
    ];

  options = {
    name = inputs.lib.mkOption {
      type = inputs.lib.types.str;
      description = "The hostname for this configuration";
    };
  };

  config = {
    services.fstrim.enable = true;

    system.stateVersion = "23.11";
    gnome.enable = inputs.lib.mkDefault true;
  };
}
