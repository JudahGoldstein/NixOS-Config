{ config, pkgs, lib, ... }:
with lib;
{
  optoins = {
    sops-user = mkOption {
      type = types.str;
      default = "";
    };

    config = {
      sops = {
        age.keyFile = "/home/${sops-user}/.config/sops/keys/age/keys.txt";

        defaultSopsFile = "../secrets.yaml";
        validateSopsFiles = false;

        secrets = {
          "private-keys/${sops-user}" = {
            path = "/home/${sops-user}/.ssh/${sops-user}";
          };
        };
      };
    };
  };
}
