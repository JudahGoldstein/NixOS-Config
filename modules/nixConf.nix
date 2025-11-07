{ config, pkgs, ... }@inputs:
{
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

  nix.settings = {
    accept-flake-config = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    download-buffer-size = 536870912; # 512MiB
    auto-optimise-store = true;
    substituters = [
      "https://nix-community.cachix.org/"
      "https://chaotic-nyx.cachix.org/"
      "https://devenv.cachix.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };
}
