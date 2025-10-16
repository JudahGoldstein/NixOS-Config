{ config, pkgs, ... }@inputs:
{
  nix.settings = {
    substituters =
      [
        "https://nix-community.cachix.org/"
      ];
    trusted-public-keys =
      [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

}
