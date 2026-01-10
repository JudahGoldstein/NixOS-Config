{ config, pkgs, ... }@inputs:
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings = {
    accept-flake-config = true;
    access-tokens = "$(cat ${config.sops.secrets.github-token.path})";
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    download-buffer-size = 536870912; # 512MiB
    auto-optimise-store = true;
    substituters = [
      "https://nix-community.cachix.org/"
      "https://cache.nixos-cuda.org"
      "https://numtide.cachix.org"
      "https://zed.cachix.org"
	  "https://cache.nixos.asia/oss"
	  "https://om.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "zed.cachix.org-1:/pHQ6dpMsAZk2DiP4WCL0p9YDNKWj2Q5FL20bNmw1cU="
	  "oss:KO872wNJkCDgmGN3xy9dT89WAhvv13EiKncTtHDItVU="
	  "om.cachix.org-1:ifal/RLZJKN4sbpScyPGqJ2+appCslzu7ZZF/C01f2Q="
    ];
  };
}
