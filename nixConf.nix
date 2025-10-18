{ config, pkgs, ... }@inputs:
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 536870912; # 512MiB
    auto-optimise-store = true;
    substituters = [
      "https://nix-community.cachix.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
