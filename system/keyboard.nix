{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs;
    [
      via
      vial

      numlockx
    ];

  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.via ];

}
