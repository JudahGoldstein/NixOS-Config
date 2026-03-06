{ config, pkgs, ... }@inputs:
{
  programs.firefox = {
    enable = true;
    preferences = {
      "privacy.resistFingerprinting" = true;
    };
  };
  hm.programs.chromium.enable = true;
}
