{ config, pkgs, ... }@inputs:
{
  options = {
    kitty.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = true;
    };
    terminal-recording.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = true;
    };
  };
  config = {
    environment.systemPackages =
      with pkgs;
      inputs.lib.mkIf config.terminal-recording.enable [
        asciinema
        asciinema-agg
        termshot
      ];
    programs.starship = {
      enable = true;
      presets = [ "no-runtime-versions" ];
    };
    programs.nautilus-open-any-terminal = inputs.lib.mkIf config.services.desktopManager.gnome.enable {
      enable = true;
      terminal = "kitty";
    };
    hm.programs.kitty = {
      enable = config.kitty.enable;
    };
  };
}
