{ config, pkgs, ... }:
{
  imports =
    [
      ./kitty.nix
      ./recording.nix
    ];
}
