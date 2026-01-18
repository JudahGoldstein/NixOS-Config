{ config, pkgs, ... }@inputs:
{
  services.atticd = {
    enable = true;
    environmentFile = "/var/lib/secrets/attic-key";
  };
}
