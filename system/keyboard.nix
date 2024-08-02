{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs;
    [
      via
      vial
    ];

  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.via ];

}
