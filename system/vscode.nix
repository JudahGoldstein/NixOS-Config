{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    vscode.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Visual Studio Code";
    };
  };

  config = mkIf config.vscode.enable {
    environment.systemPackages = with pkgs;
      [
        vscode-fhs

        # for python coding
        python3Full

        # for nix coding
        nil
        nixpkgs-fmt

        # for android development
        android-tools

        # for ardunio development
        arduino

        # for go development
        go

        # for SQL development
        dbeaver-bin
      ];

    programs = {
      direnv.enable = true;
    };
  };
}
