{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    sops-user = mkOption {
      type = types.str;
      default = "";
    };

    config = {
      sops = {
        age.keyFile = "/home/${config.sops-user}/.config/sops/keys/age/keys.txt";

        defaultSopsFile = "../secrets.yaml";
        validateSopsFiles = false;

        secrets = {
          "private-keys/${config.sops-user}" = {
            path = "/home/${config.sops-user}/.ssh/${config.sops-user}";
          };
        };
      };
    };
  };
}
