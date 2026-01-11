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
    hm.programs.opencode.enable = true;
    hm.programs.zed-editor = {
      enable = true;
      package = inputs.pkgs-stable.zed-editor;
      extensions = [
        "nix"
        "github-actions"
        "mcp-server-github"
        "opencode"
      ];
      extraPackages = with pkgs; [
        nixd
        nil
        nixfmt
      ];
      mutableUserKeymaps = true;
      mutableUserSettings = true;
      mutableUserTasks = true;
      userSettings = {
        telemetry = {
          diagnostics = false;
          metrics = true;
        };
        auto_update = false;
        agent = {
          "single_file_review" = true;
        };
        lsp = {
          nixd = {
            settings = {
              diagnostic.suppress = [
                "sema-unused-def-lambda-witharg-arg"
                "sema-unused-def-lambda-noarg-formal"
                "sema-unused-def-let"
              ];
              nixpkgs = {
                expr = "import <nixpkgs> {}";
              };
            };
            initialization_options.formatting.command = [ "nixfmt" ];
          };
          nil = {
            settings = {
              diagnostics.ignore = [
                "unused_binding"
              ];
              nix = {
                binary = "nix";
                flake = {
                  autoArchive = true;
                  autoEval = true;
                  nixpkgsInputName = "nixpkgs";
                };
              };
            };
            initialization_options.formatting.command = [ "nixfmt" ];
          };
        };
        languages = {
          Nix = {
            language_servers = [
              "nixd"
              "nil"
            ];
          };
        };
      };
    };
  };
}
