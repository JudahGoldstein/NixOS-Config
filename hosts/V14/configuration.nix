{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ../../defaultConfig.nix
    ];

  users.users.v14 = {
    isNormalUser = true;
    description = "Judah (V14)";
    extraGroups = [ "networkmanager" "wheel" "dialout" "uucp" ];
    packages = with pkgs; [ ];
  };

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
