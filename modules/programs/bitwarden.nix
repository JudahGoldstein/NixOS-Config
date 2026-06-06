{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with inputs.pkgs-insecure; [
    bitwarden-desktop
  ];
}
