{ config, pkgs, lib, ... }:
{
  options = {
    longName = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };
  config = {
    sops.secrets.user-password.neededForUsers = true;
    users.mutableUsers = false;
    users.users.${config.name} = {
      isNormalUser = true;
      description = config.longName;
      extraGroups = [ "networkmanager" "wheel" "dialout" "uucp" ];
      hashedPasswordFile = config.sops.secrets.user-password.path;
    };
    services.displayManager.autoLogin = {
      enable = false;
      user = config.name;
    };
  };
}
