{ config, pkgs, ... }@inputs:
{
  services.displayManager = {
    enable = true;
    ly = {
      enable = true;
      package = inputs.pkgs-unstable.ly;
      settings = {
        allow_empty_password = false;
        clear_password = true;
        hide_version_string = true;
        numlock = true;
      };
      x11Support = false;
    };
    generic.preStart = "";
  };
}
