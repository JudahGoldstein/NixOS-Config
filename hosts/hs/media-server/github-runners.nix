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
  users.users.github-runner-hs = {
    isSystemUser = true;
    group = "nogroup";
    description = "GitHub Runner User for HS Media Server";
  };  
  nix.settings.trusted-users = [ config.name "github-runner-hs" ];
}