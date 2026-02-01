{ config, pkgs, ... }@inputs:
{
  options = {
    longName = inputs.lib.mkOption {
      type = inputs.lib.types.str;
      default = "";
    };
  };
  config = {
    sops.secrets.user-password.neededForUsers = true;
    users.mutableUsers = false;
    users.users.${config.name} = {
      isNormalUser = true;
      description = config.longName;
      extraGroups = [
        "networkmanager"
        "wheel"
        "dialout"
        "uucp"
        "input"
        "users"
        "media"
      ];
      hashedPasswordFile = config.sops.secrets.user-password.path;
    };
    nix.settings.trusted-users = [ config.name ];
    users.groups.media = { }; # custom group for anything that touches media
    environment.extraInit = "umask 002";
  };
}
