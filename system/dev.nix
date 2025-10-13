{ config, pkgs, lib, ... }:
{
  options = {
    dev.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Development Tools";
    };
  };

  config = lib.mkIf config.dev.enable {
    environment.systemPackages = with pkgs;
      [
        vscode-fhs

        nil
        nixpkgs-fmt

        dbeaver-bin

        dotnet-sdk_9 #for polyglot 

        devenv

        nix-init
      ];

    programs = {
      direnv.enable = true;
    };
    nix.settings.trusted-users = [ "root" config.name ];
  };
}
