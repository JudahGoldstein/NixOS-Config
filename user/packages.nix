{ config, pkgs, ... }:
{
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs;
    [
    jetbrains.idea-ultimate
    obsidian
    plover.dev
    discord
    bitwarden-desktop
    libreoffice
    plover.dev
	nerdfonts
    ];

    #fix for application picker
    programs.bash.enable = true;
    targets.genericLinux.enable = true;
    xdg.mime.enable = true;
}
