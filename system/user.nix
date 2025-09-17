{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    longName = mkOption {
      type = types.str;
      default = "";
    };
  };
  config = {
    sops.secrets.user-password.neededForUsers = true;
    users.mutableUsers = false;
    users.users.${config.name} = {
      isNormalUser = true;
      description = config.longName;
      extraGroups = [ "networkmanager" "wheel" "dialout" "uucp" "docker" "vboxusers" ];
      hashedPasswordFile = config.sops.secrets.user-password.path;
    };
    services.displayManager.autoLogin = {
      enable = false;
      user = config.name;
    };
  };
}
