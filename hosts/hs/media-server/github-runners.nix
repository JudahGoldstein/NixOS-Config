{ config, pkgs, ... }@inputs:
{
  services.github-runners = {
    "hs" = {
      enable = true;
      tokenFile = "/var/lib/secrets/github-token";
      replace = true;
      extraLabels = [ "self-hosted" "linux" "x64" "nixos" ];
      noDefaultLabels = true;
      url = "https://github.com/JudahGoldstein/NixOS-Config";
      user = "github-runner-hs";
    };
  };
  nix.settings.trusted-users = [ config.name "github-runner-hs" ];
}