{ config, pkgs, ... }@inputs:
{
  programs.firefox = {
    enable = true;
    preferences = {
      "privacy.resistFingerprinting" = true;
    };
  };
  hm.programs.chromium.enable = true;
  hm.xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };
}
