{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    fastfetch
    asciinema
    asciinema-agg
    termshot
  ];
  programs.starship = {
    enable = true;
    presets = [ "no-runtime-versions" ];
  };
  hm.programs.kitty = {
    enable = true;
  };
}
