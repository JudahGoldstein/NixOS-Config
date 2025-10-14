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
    environment.systemPackages = with pkgs; inputs.lib.filter (pkg: pkg != null)
      [
        (if config.kitty.enable then kitty else null)
        (if config.terminal-recording.enable then asciinema else null)
        (if config.terminal-recording.enable then asciinema-agg else null)
        (if config.terminal-recording.enable then termshot else null)
      ];
    programs.starship = {
      enable = true;
      presets = [ "no-runtime-versions" ];
    };
    programs.nautilus-open-any-terminal = inputs.lib.mkIf config.gnome.enable {
      enable = true;
      terminal = "kitty";
    };
  };
}
