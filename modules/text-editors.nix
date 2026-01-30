{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    obsidian
    libreoffice-fresh
    micro
    hunspell
    pdftk
  ];
}
