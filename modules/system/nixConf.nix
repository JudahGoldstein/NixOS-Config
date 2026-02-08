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
      "https://attic.ts.janjuta.org/personal-cache"
      "https://nix-community.cachix.org/"
      "https://cache.nixos-cuda.org"
      "https://numtide.cachix.org"
      "https://zed.cachix.org"
      "https://cache.nixos.asia/oss" # for om in gh actions
      "https://om.cachix.org"
      "https://niri.cachix.org"
    ];
    trusted-public-keys = [
      "personal-cache:v1TL7gi821LiCxDKSqtvAq07b0KptIUPfAL7qtvWHR8="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "zed.cachix.org-1:/pHQ6dpMsAZk2DiP4WCL0p9YDNKWj2Q5FL20bNmw1cU="
      "oss:KO872wNJkCDgmGN3xy9dT89WAhvv13EiKncTtHDItVU="
      "om.cachix.org-1:ifal/RLZJKN4sbpScyPGqJ2+appCslzu7ZZF/C01f2Q="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };
}
