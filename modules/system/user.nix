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
      uid = 1000;
      description = config.longName;
      extraGroups = [
        "networkmanager"
        "wheel"
        "dialout"
        "uucp"
        "users"
        "docker"
      ];
      hashedPasswordFile = config.sops.secrets.user-password.path;
    };
    nix.settings.trusted-users = [ config.name ];
  };
}
