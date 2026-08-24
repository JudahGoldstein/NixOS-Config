{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    libreoffice-stable
    micro
    hunspell
    pdftk
  ];
  programs.evince.enable = true;
}
