{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = [ pkgs.nautilus ];
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };
}
