{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    asciinema
    asciinema-agg
    termshot
  ];
}
