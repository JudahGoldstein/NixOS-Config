{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    asciinema
    termshot
  ];
}
