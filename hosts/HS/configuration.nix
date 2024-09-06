{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../defaultConfig.nix
      ./disks.nix
    ];

  sops.secrets.user-password.neededForUsers = true;
  users.mutableUsers = false;

  users.users.hs = {
    isNormalUser = true;
    description = "Judah (HS)";
    extraGroups = [ "networkmanager" "wheel" "dialout" "uucp" ];
    packages = with pkgs; [ ];
    hashedPasswordFile = config.sops.secrets.user-password.path;
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin = {
    enable = false;
    user = "hs";
  };

  gnome.enable = true;

  networking.hostName = "HS";

  # SSD trimming
  services.fstrim.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}
