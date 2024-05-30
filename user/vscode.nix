{ config, pkgs, ... }:
{

  home.packages = with pkgs;
    [
      # for python coding
      python3Full

      # for nix coding
      nil
      nixpkgs-fmt
    ];

  programs = {
    direnv.enable = true;
    vscode.enable = true;
  };
}
