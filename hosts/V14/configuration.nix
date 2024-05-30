{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ../../defaultConfig.nix
    ];

  # Enable automatic login for the user.
  services.displayManager.autoLogin = {
    enable = false;
    user = "v14";
  };

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };
  gnome.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}
