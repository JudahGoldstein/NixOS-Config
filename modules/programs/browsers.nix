{ config, pkgs, ... }@inputs:
{
  programs.firefox = {
    enable = true;
    preferences = {
      "privacy.resistFingerprinting" = true;
    };
  };
  environment.systemPackages = with pkgs; [
    chromium
  ];
}
