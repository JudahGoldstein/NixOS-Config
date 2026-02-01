{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    wget
    curl
    p7zip
  ];
}
