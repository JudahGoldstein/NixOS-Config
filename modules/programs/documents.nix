{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    libreoffice-fresh
    micro
    hunspell
    pdftk
  ];
  programs.evince.enable = true;
}
