{ config, pkgs, ... }@inputs:
{
  hm.programs.opencode.enable = true;
  hm.programs.zed-editor = {
    enable = true;
    package = inputs.pkgs-zed.zed-editor;
    extensions = [
      "nix"
      "github-actions"
      "mcp-server-github"
      "opencode"
    ];
    extraPackages = with pkgs; [
      nixd
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
              "sema-extra-with"
            ];
            nixpkgs = {
              expr = "import <nixpkgs> {}";
            };
            autoArchive = true;
          };
          initialization_options.formatting.command = [ "nixfmt" ];
        };
      };
      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
      };
    };
  };
}
