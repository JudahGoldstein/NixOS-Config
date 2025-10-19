{ config, pkgs, ... }@inputs:
{
  options = {
    dev.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = true;
      description = "Enable Development Tools";
    };
  };

  config = inputs.lib.mkIf config.dev.enable {
    environment.systemPackages = with pkgs; [
      nil
      nixfmt

      dbeaver-bin

      dotnet-sdk_9 # for polyglot

      devenv

      nix-init
    ];

    hm.programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
    };

    programs = {
      direnv.enable = true;
    };

    nix.settings.trusted-users = [ config.name ];
  };
}
