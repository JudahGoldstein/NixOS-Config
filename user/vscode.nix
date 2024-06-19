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
      ];

    programs = {
      direnv.enable = true;
    };
  };
}
