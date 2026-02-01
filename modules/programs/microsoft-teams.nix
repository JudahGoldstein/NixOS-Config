{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    teams-for-linux
  ];
}
