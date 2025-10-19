{ config, pkgs, ... }@inputs:
{
  imports =
    [
      ./modules/networking.nix
      ./modules/ssh.nix
      ./modules/localization.nix
      ./modules/io.nix
      ./modules/sh.nix
      ./modules/packages.nix
      ./modules/antivirus.nix
      ./modules/desktop/desktop.nix
      ./modules/obs.nix
      ./modules/nh.nix
      ./modules/logitech.nix
      ./modules/keyboard.nix
      ./modules/gaming.nix
      ./modules/blocky.nix
      ./modules/sops.nix
      ./modules/user.nix
      ./modules/nix-ld.nix
      ./modules/media-server/media-server.nix
      ./modules/torrent.nix
      ./modules/docker.nix
      ./modules/wireguard.nix
      ./modules/caddy/caddy.nix
      ./modules/ollama.nix
      ./modules/firefox.nix
      ./modules/terminal.nix
      ./modules/dev.nix
      ./modules/text-editors.nix
      ./modules/audio-video.nix
      ./modules/forge.nix
      ./modules/discord.nix
      ./modules/git.nix
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

    stylix.enable = true;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    stylix.polarity = "dark";
    hm.stylix.targets.firefox.profileNames = [ "default" ];

    hm = {
      home.username = config.name;
      home.homeDirectory = "/home/${config.name}";
      home.file = { };
      home.stateVersion = "23.11";

      home.sessionVariables = {
        EDITOR = "micro";
        BROWSER = "firefox";
        TERMINAL = "kitty";
        TERM = "kitty";
      };

      programs.home-manager.enable = true;
    };
  };
}
