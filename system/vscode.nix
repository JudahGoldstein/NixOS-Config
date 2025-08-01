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

        nil
        nixpkgs-fmt

        dbeaver-bin

        #for polyglot 
        dotnet-sdk_9

        #devenv for directory based development environments
        devenv
      ];

    programs = {
      direnv.enable = true;
    };
    nix.settings.trusted-users = [ "root" config.name ];
  };
}
