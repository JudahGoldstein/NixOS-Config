{ config, pkgs, ... }:
let
  #    device = "/dev/sda";
  #    timeout = 3;
  #    configurationLimit = 5;
in
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #    boot.loader = {
  #        inherit timeout;
  #        grub = {
  #            enable = true;
  #            inherit device;
  #            useOSProber = false;
  #            inherit configurationLimit;
  #        };
  #    };
}
