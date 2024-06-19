{ config, pkgs, lib, ... }:

{
  options = {
    vscode.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Visual Studio Code";
    };
  };

  config = {
    home.packages = with pkgs;
      [
        # for python coding
        python3Full

        # for nix coding
        nil
        nixpkgs-fmt

        # for android development
        android-tools
      ];

    programs = {
      direnv.enable = true;
      vscode.enable = true;
    };
  };
}
